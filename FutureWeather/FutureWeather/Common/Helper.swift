
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
            dateFormatter.dateFormat = "MMM dd YYYY HH:MM a"

            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
           return localDate
    }
    
    static func parseCityName(from text:String) -> [String] {
        let cities = text.split(separator: ",").map { (item) -> String    in
            return  item.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return cities.count >= 3 && cities.count <= 7 ? cities : []
    }
    
}
