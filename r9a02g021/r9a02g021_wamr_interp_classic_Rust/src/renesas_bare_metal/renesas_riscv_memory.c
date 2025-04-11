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
    return os_malloc(size);
}


void
os_munmap(void *addr, size_t size)
{
    os_free(addr);
}

// Skip if include the platform/common/memory/mremap.c
void *
os_mremap(void *old_addr, size_t old_size, size_t new_size){
	os_printf("os_mremap not implemented\n");
	return os_mremap_slow(old_addr, old_size, new_size);
}

int
os_mprotect(void *addr, size_t size, int prot){
#if (BH_RENESAS_DEBUG ==1 )
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
#if (BH_RENESAS_DEBUG ==1 )
	os_printf("Warning: function os_dcache_flush() is not implemented\n");
#endif
}

/**
 * Flush instruction cache.
 */
void
os_icache_flush(void *start, size_t len)
{
#if (BH_RENESAS_DEBUG ==1 )
	os_printf("Warning: function os_icache_flush() is not implemented\n");
#endif
}

#if (WASM_MEM_DUAL_BUS_MIRROR != 0)
void *
os_get_dbus_mirror(void *ibus)
{
#if (BH_RENESAS_DEBUG ==1 )
	os_printf("Warning: function os_get_dbus_mirror() is not implemented\n");
#endif
}
#endif
