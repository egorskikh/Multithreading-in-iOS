import UIKit

class SemaphoreTest {
    
    static var shared = SemaphoreTest()
    
    private let semaphore = DispatchSemaphore(value: 0)
    
    func test() {
        DispatchQueue.global().async {
            sleep(3)
            print("1")
            self.semaphore.signal()
        }
        semaphore.wait()
        print("2")
    }
    
}
//SemaphoreTest.shared.test()

class SemaphoreTest2 {
    
    static var shared = SemaphoreTest2()
    
    private let semaphore = DispatchSemaphore(value: 2)
    
    func doWork() {
        semaphore.wait()
        print("Queuetest start")
        sleep(3) // Do something
        semaphore.signal()
    }
    
    func test() {
        DispatchQueue.global().async {
            self.doWork()
            print("Queue 1")
        }
        DispatchQueue.global().async {
            self.doWork()
            print("Queue 2")
        }
        DispatchQueue.global().async {
            self.doWork()
            print("Queue 3")
        }
    }
    
}
SemaphoreTest2.shared.test()
