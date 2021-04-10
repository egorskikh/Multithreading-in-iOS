import UIKit

class DispatchBarrierTest {
    
    private let queue = DispatchQueue(label: "DispatchBarrierTest", attributes: .concurrent)
    
    private var internalTest: Int = 0
    
    func setTest(_ test: Int) {
        queue.async(flags: .barrier ) {
            self.internalTest = test
        }
    }
    
    func test() -> Int {
        
        var tmp: Int = 0
        queue.sync {
            tmp = self.internalTest
        }
        return tmp
    }
}
