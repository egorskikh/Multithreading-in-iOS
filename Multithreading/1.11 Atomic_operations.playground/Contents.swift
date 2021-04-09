import UIKit

class AtomicOperationsPseudoCodeTest {
    
    func compareAndSwap(old: Int, new: Int, value: UnsafeMutablePointer<Int>) -> Bool {
        if value.pointee == old {
            value.pointee = new
            return true
        }
        return false
    }
    
    func atomicAdd(amount: Int, value: UnsafeMutablePointer<Int>) -> Int {
        var success = false
        var new: Int = 0
        
        while !success {
            let original = value.pointee
            new = original + amount
            success = compareAndSwap(old: original, new: new, value: value)
        }
        return new
    }
    
}

class AtomicOperationsTest {
    private var i: Int64 = 0
    
    func test() {
        OSAtomicCompareAndSwap64Barrier(i, 10, &i)
        OSAtomicAdd64Barrier(20, &i)
        OSAtomicIncrement64Barrier(&i)
    }
}


class MemoryBarrierTest {
    
    class TestClass {
        var t1: Int?
        var t2: Int?
    }
    var testClass: TestClass?
    
    func test() {
        let thread1 = Thread {
            let tmp = TestClass()
            tmp.t1 = 100
            tmp.t2 = 500
            OSMemoryBarrier()
            self.testClass = tmp
        }
        thread1.start()
        
        let thread2 = Thread {
            while self.testClass == nil {
                OSMemoryBarrier()
                print(self.testClass?.t1)
            }
        }
        thread2.start()
    }
    
}
