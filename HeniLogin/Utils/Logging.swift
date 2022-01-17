
import Foundation
//import Embrace


class Logging {
    
    class func JLog(message: String, functionName: String = #function, fileName: String = #file, lineNum: Int = #line) {
        
        NSLog ("\(fileName): \(functionName): \(lineNum): \(message)")
    }
    
    /*
    class func logError (message: String) {
        
        Embrace.sharedInstance().logMessage(message,
          with: .error,
          properties: [:], // optional
          takeScreenshot: true)
        
    }
    
    class func logInfo (message: String) {
        
        Embrace.sharedInstance().logMessage(message,
          with: .info,
          properties: [:], // optional
          takeScreenshot: true)
        
    }*/
}
