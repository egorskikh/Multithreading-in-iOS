import UIKit

/// Synchronization
/*
 1 потом может одновременно захватить mutex
 */

// pthread_mutex

class TestMutex {
    
    private var mutex = pthread_mutex_t()
    
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    
    func test() {
        pthread_mutex_lock(&mutex)
        //Do something
        pthread_mutex_unlock(&mutex)
    }
    
}

// NSLock

public class NSLockTest {
    
    private let lock = NSLock()
    
    func test(i: Int) {
        lock.lock()
        // Do something
        lock.unlock()
    }
    
}
