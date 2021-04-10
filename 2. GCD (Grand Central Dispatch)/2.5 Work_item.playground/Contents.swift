import UIKit

class DispatchWorkItemTest {

    static var shared = DispatchWorkItemTest()
    
    private let queue = DispatchQueue(label: "DispatchWorkItemTest1", attributes: .concurrent)
    
    func testNotify() {
        
        let item = DispatchWorkItem {
            print("test start")
        }

        item.notify(queue: DispatchQueue.main) {
            print("test finish")
        }
        queue.async(execute: item)
        
    }
}

//DispatchWorkItemTest.shared.testNotify()

class DispatchWorkItemTest2 {

    static var shared = DispatchWorkItemTest2()
    
    private let queue = DispatchQueue(label: "DispatchWorkItemTest2")
    
    func testCancel() {
        
        queue.async {
            sleep(3)
            print("test1")
        }
        
        queue.async {
            sleep(3)
            print("test2")
        }
        
        let item = DispatchWorkItem {
            print("test")
        }
        queue.async(execute: item)
        
        item.cancel()
    }
    
}
//DispatchWorkItemTest2.shared.testCancel()


