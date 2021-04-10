import UIKit

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
