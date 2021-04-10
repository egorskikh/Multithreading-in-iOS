import Foundation

class SpinLockTest {
    
    private var lock = OS_SPINLOCK_INIT
    
    func test(){
        OSSpinLockLock(&lock)
        // Do something
        OSSpinLockUnlock(&lock)
    }
}


// Unfair Lock

class UnfairLockTest {
    
    private var lock = os_unfair_lock_s()
    
    func test() {
        os_unfair_lock_lock(&lock)
        // Do something
        os_unfair_lock_unlock(&lock)
    }
    
}


