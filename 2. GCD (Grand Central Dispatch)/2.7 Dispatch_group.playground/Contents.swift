import UIKit

class DispatchGroupTest1 {
    
    static var shared = DispatchGroupTest1()
    
    private let group = DispatchGroup()
    private let queue = DispatchQueue(label: "DispatchGroupTest1", attributes: .concurrent)
    
    func testNotify() {
        
        queue.async(group: group) {
            sleep(1)
            print("1")
        }
        
        queue.async(group: group) {
            sleep(2)
            print("2")
        }
        group.notify(queue: DispatchQueue.main) {
            print("finish")
        }
    }
    
    
}
//DispatchGroupTest1.shared.testNotify()

class DispatchGroupTest2 {
    
    static var shared = DispatchGroupTest2()
    
    private let group = DispatchGroup()
    private let queue = DispatchQueue(label: "DispatchGroupTest2", attributes: .concurrent)
    
    func testWait() {
        group.enter()
        queue.async {
            sleep(1)
            print("1")
            self.group.leave()
        }
        group.enter()
        queue.async {
            sleep(2)
            print("2")
            self.group.leave()
        }
        group.wait()
        print("finsh all")
    }
    
    
}
DispatchGroupTest2.shared.testWait()
