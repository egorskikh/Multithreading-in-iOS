import UIKit

// Recursive lock
/*
 Разрешить потоку захватывать один и тот же ресурс несколько раз
 */

class RecursiveMutexTest {
    
    private var mutex = pthread_mutex_t()
    private var attr = pthread_mutexattr_t()
    
    init() {
        pthread_mutexattr_init(&attr)
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attr)
    }
    
    func test1() {
        pthread_mutex_lock(&mutex)
        test2()
        pthread_mutex_unlock(&mutex)
    }
    
    func test2() {
        pthread_mutex_lock(&mutex)
        pthread_mutex_unlock(&mutex)
    }
    
}

class RecursiveLockTest {
    
    private let lock = NSRecursiveLock()
    
    func test1(){
        lock.lock()
        test2()
        lock.unlock()
    }
    
    func test2(){
        lock.lock()
        // Do something
        lock.unlock()
    }
    
}
