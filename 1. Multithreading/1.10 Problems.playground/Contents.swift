import UIKit

class DeadLockTest {
    private let lock1 = NSLock()
    private let lock2 = NSLock()
    var resourceA = false
    var resourceB = false
}

/*
let thread1 = Thread {
    self.lock1.lock()
    
    self.resourceA = true
    
    self.lock2.lock()
    self.resourceB = true
    self.lock2.unlock()
    
    self.lock1.unlock()
    
    
}
thread1.start()

let thread2 = Thread {
    self.lock2.lock()
    
    self.resourceB = true
    
    self.lock1.lock()
    self.resourceA = true
    self.lock1.unlock()
    
    self.lock2.unlock()
    
    
}
thread2.start()
*/


