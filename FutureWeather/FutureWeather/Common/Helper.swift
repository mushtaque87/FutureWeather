
import UIKit


final public class Helper: NSObject {
    
    static func readJsonFile(at path:String , ofType type:String) -> Data?
    {
        var data : Data?
        guard Bundle.main.path(forResource: path, ofType: type) != nil else {
            return nil
            
        }
        
        
        do {
            if let file = Bundle.main.url(forResource: path, withExtension: type) {
                data = try Data(contentsOf: file)
                
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if json is [String: Any] {
                    // json is a dictionary
                } else if json is [Any] {
                    // json is an array
                } else {
                }
            } else {
            }
        } catch {
        }
        return data
    }
    
    static func covertDateToString(date:Double) -> String {
       
            let date = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
//            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
//            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.dateFormat = "MMM dd YYYY HH:MM a"

            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
           return localDate
    }
    
}
