import Foundation

/// Create stream

var thread = pthread_t(bitPattern: 0)
var attr = pthread_attr_t()

pthread_attr_init(&attr)
pthread_create(&thread, &attr, { pointer in
    print("Test 1")
    
    return nil
}, nil)


var nsthread = Thread {
    print("Test 2")
}
nsthread.start()




/// Basic concepts

var thread1 = pthread_t(bitPattern: 0)
var attr1 = pthread_attr_t()
 
pthread_attr_init(&attr1)
pthread_create(&thread1, &attr1, { pointer in
 
   print("thread1")
 
   return nil
}, nil)
 
var thread2 = pthread_t(bitPattern: 0)
var attr2 = pthread_attr_t()
 
pthread_attr_init(&attr2)
pthread_create(&thread2, &attr2, { pointer in
    print("thread2")
    return nil
}, nil)

// random


let thread3 = Thread {
   print("thread3")
   let thread4 = Thread {
        print("thread4")
   }
   thread4.start()
}

thread3.start()

// print 3, print 4



/// Quality of service

/*
public enum QualityOfService : Int {
    
    case userInteractive  // UI
    case userInitiated   // save ect...
    case utility        // load data ect...
    case background    // Synchronization, background ect...
    
    case "default"
}

*/


class PthreadQosTest {
    
    static let shared = PthreadQosTest()
    
    func test() {
        var thread = pthread_t(bitPattern: 0)
        var attribute = pthread_attr_t()
        pthread_attr_init(&attribute)
        pthread_attr_set_qos_class_np(&attribute, QOS_CLASS_USER_INITIATED, 0) // priority
        pthread_create(&thread, &attribute, { poiner in
            
            print("Test class")
            pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0) // Sets the requested QOS class and relative priority of the current thread.
            
            return nil
        }, nil)
        
        
    }
    
}
PthreadQosTest.shared.test()


class QosThreadTest {
    
    static let shared = QosThreadTest()
    
    func test() {
        let thread = Thread {
            print("QosThreadTest")
            print(qos_class_self()) // qualityOfService this stream
        }
        thread.qualityOfService = .userInteractive
        thread.start()
        
        print(qos_class_main()) // qualityOfService main stream
    }
    
}
QosThreadTest.shared.test()



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



/// Condition

class MutexConditionTest {
    private var condition = pthread_cond_t()
    private var mutex = pthread_mutex_t()
    private var check = false
    
    init(){
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    func test1(){
        print("MutexConditionTest - start")
        pthread_mutex_lock(&mutex)
        print("MutexConditionTest - lock")
        while !check {
            print("MutexConditionTest - !check - cycle loop")
            pthread_cond_wait(&condition, &mutex)
        }
        print("MutexConditionTest - DO SOME WORK")
        pthread_mutex_unlock(&mutex)
        print("MutexConditionTest - unlock")
    }
    
    func test2(){
        print("MutexConditionTest - test2() - start")
        pthread_mutex_lock(&mutex)
        check = true
        pthread_cond_signal(&condition)
        print("MutexConditionTest - test2() - unlocking mutex")
        pthread_mutex_unlock(&mutex)
        print("MutexConditionTest - test2() - end")
    }
    
}

// NSCondition

class ConditionTest {
    
    private let condition = NSCondition()
    private var check: Bool = false
    
    func test1() {
        
        condition.lock()
        while(!check) {
            condition.wait()
        }
        condition.unlock()
    }

    func test2() {
        condition.lock()
        
        check = true
        condition.signal()
        condition.unlock()
    }
    
}

