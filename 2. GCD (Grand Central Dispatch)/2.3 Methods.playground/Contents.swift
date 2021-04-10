import UIKit

class AsyncVsSyncTest1 {
    
    static var shared = AsyncVsSyncTest1()
    
    private let serialQueue = DispatchQueue(label: "serialTest")
    
    func test() {
        
        serialQueue.async {
            print("AsyncVsSyncTest 1 - Test 1")
        }
        
        serialQueue.async {
            sleep(1)
            print("AsyncVsSyncTest 1 - Test 2")
        }
        
        serialQueue.sync {
            print("AsyncVsSyncTest 1 - Test 3")
        }
        
        serialQueue.sync {
            print("AsyncVsSyncTest 1 - Test 4")
        }
        
    }
    
}

class AsyncVsSyncTest2 {
    
    static var shared = AsyncVsSyncTest2()
    
    private let concurrentQueue = DispatchQueue.global()
    
    func test() {
        
        concurrentQueue.async {
            print("AsyncVsSyncTest 2 - Test 1")
        }
        
        concurrentQueue.async {
            print("AsyncVsSyncTest 2 - Test 2")
        }
        
        concurrentQueue.sync {
            print("AsyncVsSyncTest 2 - Test 3")
        }
        
        concurrentQueue.sync {
            print("AsyncVsSyncTest 2 - Test 4")
        }
        
    }
    
}

class AsyncVsSyncTest {
    
    static var shared = AsyncVsSyncTest()
    
    private let concurrentQueue = DispatchQueue(label: "AsyncAfterTest", attributes: .concurrent)
    
    func test() {
        concurrentQueue.asyncAfter(deadline: .now() + 3 ) {
            print("AsyncVsSyncTest - Test")
        }
    }
    
}

//AsyncVsSyncTest1.shared.test()
//AsyncVsSyncTest2.shared.test()
AsyncVsSyncTest.shared.test()
