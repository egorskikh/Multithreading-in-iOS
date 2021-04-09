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
