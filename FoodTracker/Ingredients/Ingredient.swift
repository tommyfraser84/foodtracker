import Foundation

class Ingredient: NSObject, NSCoding{
    
    struct PropertyKey {
        static let name = "name"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
       // self.name = name
        let name = aDecoder.decodeObject(forKey: PropertyKey.name)
        self.init(name: name as! String)
    }

    var name: String;
    init(name: String) {
        self.name = name
    }
}
