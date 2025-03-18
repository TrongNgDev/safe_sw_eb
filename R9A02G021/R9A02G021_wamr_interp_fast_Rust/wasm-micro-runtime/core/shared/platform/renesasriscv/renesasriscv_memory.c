#include "platform_api_vmcore.h"
#include "platform_api_extension.h"

/*
*  Simple os_mmap() for bare-metal
*  - Not support memory map modes (MMAP_PROT_NONE/READ/WRITE/EXEC) 
*  - Not support memory map flags (MMAP_MAP_NONE/32BIT/FIXED)
*/
void *
os_mmap(void *hint, size_t size, int prot, int flags, os_file_handle file)
{
    void *buf_origin;
    void *buf_fixed;
    uintptr_t *addr_field;

    buf_origin = malloc(size + 8 + sizeof(uintptr_t));
    if (!buf_origin) {
        return NULL;
    }

    buf_fixed = buf_origin + sizeof(void *);
    if ((uintptr_t)buf_fixed & (uintptr_t)0x7) {
        buf_fixed = (void *)((uintptr_t)(buf_fixed + 8) & (~(uintptr_t)7));
    }

    addr_field = buf_fixed - sizeof(uintptr_t);
    *addr_field = (uintptr_t)buf_origin;

    memset(buf_origin, 0, size + 8 + sizeof(uintptr_t));
    return buf_fixed;
}


void
os_munmap(void *addr, size_t size)
{
    void *mem_origin;
    uintptr_t *addr_field;

    if (addr) {
        addr_field = addr - sizeof(uintptr_t);
        mem_origin = (void *)(*addr_field);
        free(mem_origin);
    }
}

// Skip if include the platform/common/memory/mremap.c
void *
os_mremap(void *old_addr, size_t old_size, size_t new_size){
	return os_mremap_slow(old_addr, old_size, new_size);
}

int
os_mprotect(void *addr, size_t size, int prot){
#if defined(BH_RENESAS_DEBUG)
	 os_printf("Warning: function os_mprotect() is not implemented\n");
#endif
	return 0;
}

/**
 * Flush cpu data cache, in some CPUs, after applying relocation to the
 * AOT code, the code may haven't been written back to the cpu data cache,
 * which may cause unexpected behaviour when executing the AOT code.
 * Implement this function if required, or just leave it empty.
 */
void
os_dcache_flush(void)
{
#if defined(BH_RENESAS_DEBUG)
	 os_printf("Warning: function os_dcache_flush() is not implemented\n");
#endif
}

/**
 * Flush instruction cache.
 */
void
os_icache_flush(void *start, size_t len)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("Warning: function os_icache_flush() is not implemented\n");
#endif
}

#if (WASM_MEM_DUAL_BUS_MIRROR != 0)
void *
os_get_dbus_mirror(void *ibus)
{
	os_printf("WAMR: function os_get_dbus_mirror() not implemented\n");
}
#endif
