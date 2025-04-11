#include "platform_api_vmcore.h"
#include "platform_api_extension.h"

/**
 * Symbols extracted from linker_script.ld for ECCRAM and RAM
 */
extern char __heap_eccram_start;
extern char __heap_eccram_end;
extern char __heap_ram_start;
extern char __heap_ram_end;


/**
 * @brief Get all free memory in ECCRAM as heap
 */
void
renesas_heap_init_eccram(void)
{
	if (heap_eccram != NULL) {
		return;
	}
	uint32_t v, p;
	block_t *block_eccram;
	v = (uint32_t)&__heap_eccram_start;
	p = (v + 7) & ~7;
	heap_eccram = (heap_t *)p;
	block_eccram = (block_t *)(heap_eccram + 1);
	heap_eccram->free = block_eccram;
	heap_eccram->used = NULL;
	heap_eccram->free_size = (uint32_t)&__heap_eccram_end - (uint32_t)block_eccram;
	heap_eccram->used_size = 0;
	block_eccram->addr = (void *)(block_eccram + 1);
	block_eccram->next = NULL;
	block_eccram->size = (uint32_t)&__heap_eccram_end - (uint32_t)block_eccram->addr;
}


/**
 * @brief Get all free memory in RAM as heap
 */
void
renesas_heap_init_ram(void)
{
	if (heap_ram != NULL) {
		return;
	}
	uint32_t v, p;
	block_t *block_ram;
	v = (uint32_t)&__heap_ram_start;
	p = (v + 7) & ~7;
	heap_ram = (heap_t *)p;
	block_ram = (block_t *)(heap_ram + 1);
	heap_ram->free = block_ram;
	heap_ram->used = NULL;
	heap_ram->free_size = (uint32_t)&__heap_ram_end - (uint32_t)block_ram;
	heap_ram->used_size = 0;
	block_ram->addr = (void *)(block_ram + 1);
	block_ram->next = NULL;
	block_ram->size = (uint32_t)&__heap_ram_end - (uint32_t)block_ram->addr;
}


/**
 * @brief Print heap information
 */
void
renesas_heap_print_info(void)
{
	os_printf("Heap information:\n");
	os_printf("ECCRAM Heap from %p to %p, used %d bytes, free %d bytes\n",
				(char*)&__heap_eccram_start, (char*)&__heap_eccram_end,
				heap_eccram->used_size + sizeof(heap_t), heap_eccram->free_size);
	os_printf("RAM Heap    from %p to %p, used %d bytes, free %d bytes\n",
				(char*)&__heap_ram_start, (char*)&__heap_ram_end,
				heap_ram->used_size + sizeof(heap_t), heap_ram->free_size);
}


/**
 * @brief Merge all continuous blocks of memory in "free" linked-list
 */
void
renesas_merge_free_blocks(heap_t *heap)
{
	block_t *ptr = heap->free;
	block_t *prev, *scan;
	while (ptr != NULL) {
		prev = ptr;
		scan = ptr->next;
		while (scan != NULL) {
			if (((uint32_t)prev->addr + prev->size) == (uint32_t)scan) {
				prev = scan;
				scan = scan->next;
			} else {
				break;
			}
		}
		if (prev != ptr) {
			ptr->next = prev->next;
			ptr->size = (uint32_t)prev->addr + prev->size - (uint32_t)ptr->addr;
		}
		ptr = ptr->next;
	}
}


/**
 * @brief Insert a block of memory into "free" linked-list
 */
void
renesas_insert_block(heap_t *heap, block_t *block)
{
	block_t *ptr = heap->free;
	block_t *prev = NULL;
	while (ptr != NULL) {
		if ((uint32_t)ptr >= (uint32_t)block) {
			break;
		}
		prev = ptr;
		ptr = ptr->next;
	}

	if (prev != NULL) {
		prev->next = block;
		block->next = ptr;
	} else {
		heap->free = block;
		block->next = ptr;
	}
	renesas_merge_free_blocks(heap);
}


/**
 * @brief Free a block of memory
 */
bool
renesas_free_block(void* free_ptr)
{
	heap_t *heap_sel;
	block_t *ptr, *prev;

	/* check linker file, ram address > eccram address */
	if ((uint32_t)free_ptr > (uint32_t)heap_ram) {
		heap_sel = heap_ram;
	} else {
		heap_sel = heap_eccram;
	}
	ptr = heap_sel->used;
	prev = NULL;

	while (ptr != NULL) {
		if (free_ptr == ptr->addr) {
			// Remove from "used" linked list of heap
			if (prev != NULL) {
				prev->next = ptr->next;
			} else {
				heap_sel->used = ptr->next;
			}
			heap_sel->free_size = heap_sel->free_size + ptr->size + sizeof(block_t);
			heap_sel->used_size = heap_sel->used_size - ptr->size - sizeof(block_t);

			// Add to "free" linked list of heap
			renesas_insert_block(heap_sel, ptr);
			return true;
		}
		prev = ptr;
		ptr = ptr->next;
	}
	return false;
}


/**
 * @brief Allocate new block of memory
 */
block_t *
renesas_alloc_block (uint32_t size, heap_t *heap)
{
	/* Quick check if total free space in this heap is sufficient */
	if (heap->free_size <= (size + sizeof(block_t))) {
		return NULL;
	}

	block_t *ptr = heap->free;
	block_t *prev = NULL;
	while (ptr != NULL) {
		if (ptr->size >= size) {
			uint32_t size_excess = ptr->size - size;
			if (size_excess >= RENESAS_BLOCK_SIZE_MIN) {
				//split block
				block_t *new_block = (block_t *)((uint32_t)ptr->addr + size);
				ptr->size = size;
				new_block->addr = (void *)(new_block + 1);
				new_block->next = ptr->next;
				new_block->size = size_excess - sizeof(block_t);
				if (prev == NULL) {
					heap->free = new_block;
				} else {
					prev->next = new_block;
				}
			} else {
				/* take whole block */
				if (prev == NULL) {
					heap->free = ptr->next;
				} else {
					prev->next = ptr->next;
				}
			}
			ptr->next = heap->used;
			heap->used = ptr;
			heap->free_size = heap->free_size - ptr->size - sizeof(block_t);
			heap->used_size = heap->used_size + ptr->size + sizeof(block_t);
			return ptr;
		}//end if(ptr->size >= size)

		prev = ptr;
		ptr = ptr->next;
	} //end while(ptr != NULL)

	return NULL; //not enough free space
}


/*=======================================================================*/
/*       The following functions are created for WAMR                    */
/*=======================================================================*/
/**
 * @brief Allocate memory
 */
void *
os_malloc(unsigned size)
{
	uint32_t aligned_size = ((uint32_t)size + 7) & ~7;
	block_t *block = renesas_alloc_block(aligned_size, heap_eccram);
	if (block == NULL) {
		block = renesas_alloc_block(aligned_size, heap_ram);
		if (block == NULL) {
			os_printf("ERROR not enough ECCRAM/RAM for allocation\n");
			os_printf("Request %d, ERRAM remains %d, RAM remains %d\n", size, heap_eccram->free_size, heap_ram->free_size);
			return NULL;
		}
	}
	return block->addr;
}

/**
 * @brief Reallocate memory
 */
void *
os_realloc(void *ptr, unsigned size)
{
    os_printf("ERROR: The os_realloc() function is not implemented\n");
    return NULL;
}

/**
 * @brief Free memory
 */
void
os_free(void *ptr)
{
	renesas_free_block(ptr);
}

/**
 * @brief Dump memory information
 */
int
os_dumps_proc_mem_info(char *out, unsigned int size)
{
    return -1;
}
