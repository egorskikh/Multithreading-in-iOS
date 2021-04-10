import UIKit

class DispatchSourceTest1 {
    
    private let source = DispatchSource.makeTimerSource()
    
    func test() {
        source.setEventHandler {
            print("test")
        }
        source.schedule(deadline: .now(), repeating: 5)
        source.activate()
    }
}

class DispatchSourceTest2 {
    
    private let source = DispatchSource.makeUserDataAddSource(queue: DispatchQueue.main)
    
    init() {
        source.setEventHandler {
            print(self.source.data)
        }
        source.activate()
    }
    
    func test() {
        
        DispatchQueue.global().async {
            self.source.add(data: 10)
        }
    }
}


