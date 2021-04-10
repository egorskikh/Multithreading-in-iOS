import UIKit

class ConcurrentPerformTest {
    
    static var shared = ConcurrentPerformTest()
    
    func test() {
        DispatchQueue.concurrentPerform(iterations: 3) { (i) in
            print(i)
        }
    }
    
}
ConcurrentPerformTest.shared.test()
