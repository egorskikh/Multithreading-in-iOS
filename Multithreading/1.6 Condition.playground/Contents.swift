import UIKit

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
