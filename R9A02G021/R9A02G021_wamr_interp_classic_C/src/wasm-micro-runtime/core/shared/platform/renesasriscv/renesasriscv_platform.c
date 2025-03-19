#include "platform_api_vmcore.h"
#include "platform_api_extension.h"

/****************************************************
 * 					API VMCORE FUNCTIONS            *
 ****************************************************
 *                     Section 1                    *
 *        Interfaces required by the runtime        *
 ****************************************************/
/**
 * Initialize the platform internal resources if needed,
 * this function is called by wasm_runtime_init() and
 * wasm_runtime_full_init()
 *
 * @return 0 if success
 */
int
bh_platform_init(void)
{
    return 0; //0 if success
}

/**
 * Destroy the platform internal resources if needed,
 * this function is called by wasm_runtime_destroy()
 */
void
bh_platform_destroy(void)
{}


/**
 * os_printf() - redirect message to JLinkRTTViewer terminal 0
 */
int
os_printf(const char *format, ...)
{
	  int r;
	  va_list ParamList;
	  va_start(ParamList, format);
	  r = SEGGER_RTT_vprintf(0, format, &ParamList);
	  va_end(ParamList);
	  return r;
}

/**
 * os_vprintf() - redirect message to JLinkRTTViewer terminal 0
 */
int
os_vprintf(const char *format, va_list ap)
{
    return SEGGER_RTT_vprintf(0, format, ap);
}

/**
 * Get microseconds after boot.
 */
uint64
os_time_get_boot_us(void)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_time_get_boot_us() is not implemented\n");
#endif
    return 0;
}

/**
 * Get thread-specific CPU-time clock in microseconds
 */
uint64
os_time_thread_cputime_us(void)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_time_thread_cputime_us() is not implemented\n");
#endif
    return os_time_get_boot_us();
}

/**
 * Get current thread id.
 * Implementation optional: Used by runtime for logging only.
 */
korp_tid
os_self_thread(void){
#if defined(BH_RENESAS_DEBUG)
    os_printf("WAMR: function os_self_thread() is not implemented\n");
#endif
    korp_tid id = 0;
    return id;
}

/**
 * Get current thread's stack boundary address, used for runtime
 * to check the native stack overflow. Return NULL if it is not
 * easy to implement, but may have potential issue.
 */
uint8 *
os_thread_get_stack_boundary(void)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_thread_get_stack_boundary() is not implemented\n");
#endif
    return NULL;
}

/**
 * Set whether the MAP_JIT region write protection is enabled for this thread.
 * Pass true to make the region executable, false to make it writable.
 */
void
os_thread_jit_write_protect_np(bool enabled)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_thread_jit_write_protect_np() is not implemented\n");
#endif
}

/**
 ************** mutext APIs ***********
 *  vmcore:  Not required until pthread is supported by runtime
 *  app-mgr: Must be implemented
 */

int
os_mutex_init(korp_mutex *mutex)
{
    return 0;
}

int
os_mutex_destroy(korp_mutex *mutex)
{
    return 0;
}

int
os_mutex_lock(korp_mutex *mutex)
{
    return 0;
}

int
os_mutex_unlock(korp_mutex *mutex)
{
    return 0;
}

/****************************************************
 * 					API EXTENSION FUNCTIONS         *
 ****************************************************
 *                     Section 1                    *
 *                Multi thread support              *
 ****************************************************/
/**
 * NOTES:
 * 1. If you are building VM core only, it must be implemented to
 *    enable multi-thread support, otherwise no need to implement it
 * 2. To build the app-mgr and app-framework, you must implement it
 */

/**
 * Creates a thread
 *
 * @param p_tid  [OUTPUT] the pointer of tid
 * @param start  main routine of the thread
 * @param arg  argument passed to main routine
 * @param stack_size  bytes of stack size
 *
 * @return 0 if success.
 */
int
os_thread_create(korp_tid *p_tid, thread_start_routine_t start, void *arg,
                 unsigned int stack_size)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_thread_create() is not implemented\n");
#endif
	return 0;
}

/**
 * Creates a thread with priority
 *
 * @param p_tid  [OUTPUT] the pointer of tid
 * @param start  main routine of the thread
 * @param arg  argument passed to main routine
 * @param stack_size  bytes of stack size
 * @param prio the priority
 *
 * @return 0 if success.
 */
int
os_thread_create_with_prio(korp_tid *p_tid, thread_start_routine_t start,
                           void *arg, unsigned int stack_size, int prio)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_thread_create_with_prio() is not implemented\n");
#endif
	return 0;
}

/**
 * Waits for the thread specified by thread to terminate
 *
 * @param thread the thread to wait
 * @param retval if not NULL, output the exit status of the terminated thread
 *
 * @return return 0 if success
 */
int
os_thread_join(korp_tid thread, void **retval)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_thread_join() is not implemented\n");
#endif
	return 0;
}

/**
 * Detach the thread specified by thread
 *
 * @param thread the thread to detach
 *
 * @return return 0 if success
 */
int os_thread_detach(korp_tid)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_thread_detach() is not implemented\n");
#endif
	return 0;
}

/**
 * Exit current thread
 *
 * @param retval the return value of the current thread
 */
void
os_thread_exit(void *retval)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_thread_exit() is not implemented\n");
#endif
}

/**
 * Initialize current thread environment if current thread
 * is created by developer but not runtime
 *
 * @return 0 if success, -1 otherwise
 */
int
os_thread_env_init(void)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_thread_env_init() is not implemented\n");
#endif
	return 0;
}

/**
 * Destroy current thread environment
 */
void
os_thread_env_destroy(void)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_thread_env_destroy() is not implemented\n");
#endif
}

/**
 * Whether the thread environment is initialized
 */
bool
os_thread_env_inited(void)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_thread_env_inited() is not implemented\n");
#endif
	return false;
}

/**
 * Suspend execution of the calling thread for (at least)
 * usec microseconds
 *
 * @return 0 if success, -1 otherwise
 */
int
os_usleep(uint32 usec)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_usleep() is not implemented\n");
#endif
	return 0;
}

/**
 * Creates a recursive mutex
 *
 * @param mutex [OUTPUT] pointer to mutex initialized.
 *
 * @return 0 if success
 */
int
os_recursive_mutex_init(korp_mutex *mutex)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_recursive_mutex_init() is not implemented\n");
#endif
	return 0;
}

/**
 * This function creates a condition variable
 *
 * @param cond [OUTPUT] pointer to condition variable
 *
 * @return 0 if success
 */
int
os_cond_init(korp_cond *cond)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_cond_init() is not implemented\n");
#endif
    return 0;
}

/**
 * This function destroys condition variable
 *
 * @param cond pointer to condition variable
 *
 * @return 0 if success
 */
int
os_cond_destroy(korp_cond *cond)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_cond_destroy() is not implemented\n");
#endif
	return 0;
}

/**
 * Wait a condition variable.
 *
 * @param cond pointer to condition variable
 * @param mutex pointer to mutex to protect the condition variable
 *
 * @return 0 if success
 */
int
os_cond_wait(korp_cond *cond, korp_mutex *mutex)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_cond_wait() is not implemented\n");
#endif
	return 0;
}

/**
 * Wait a condition varible or return if time specified passes.
 *
 * @param cond pointer to condition variable
 * @param mutex pointer to mutex to protect the condition variable
 * @param useconds microseconds to wait
 *
 * @return 0 if success
 */
int
os_cond_reltimedwait(korp_cond *cond, korp_mutex *mutex, uint64 useconds)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_cond_reltimedwait() is not implemented\n");
#endif
	return 0;
}

/**
 * Signals the condition variable
 *
 * @param cond condition variable
 *
 * @return 0 if success
 */
int
os_cond_signal(korp_cond *cond)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_cond_signal() is not implemented\n");
#endif
	return 0;
}

/**
 * Broadcast the condition variable
 *
 * @param cond condition variable
 *
 * @return 0 if success
 */
int
os_cond_broadcast(korp_cond *cond)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_cond_broadcast() is not implemented\n");
#endif
	return 0;
}

/**
 * Initialize readwrite lock object
 *
 * @param cond [OUTPUT] pointer to a lock object variable
 *
 * @return 0 if success
 */
int
os_rwlock_init(korp_rwlock *lock)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_rwlock_init() is not implemented\n");
#endif
	return 0;
}

/**
 * Acquire the read lock
 *
 * @param lock lock variable
 *
 * @return 0 if success
 */
int
os_rwlock_rdlock(korp_rwlock *lock)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_rwlock_rdlock() is not implemented\n");
#endif
	return 0;
}

/**
 * Acquire the write lock
 *
 * @param lock lock variable
 *
 * @return 0 if success
 */
int
os_rwlock_wrlock(korp_rwlock *lock)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_rwlock_wrlock() is not implemented\n");
#endif
	return 0;
}

/**
 * Unlocks the lock object
 *
 * @param lock lock variable
 *
 * @return 0 if success
 */
int
os_rwlock_unlock(korp_rwlock *lock)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_rwlock_unlock() is not implemented\n");
#endif
	return 0;
}

/**
 * Destroy a lock object
 *
 * @param lock lock variable
 *
 * @return 0 if success
 */
int
os_rwlock_destroy(korp_rwlock *lock)
{
#if defined(BH_RENESAS_DEBUG)
	os_printf("WAMR: function os_rwlock_destroy() is not implemented\n");
#endif
	return 0;
}

/**
 * NOTES:
 * Other functions defined in platform_api_extension.h are not used in
 * this project, so they are not implemented here.
 */
