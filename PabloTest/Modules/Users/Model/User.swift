//
//  User.swift
//  PabloTest
//
//  Created by Pablo Duarte on 10/12/21.
//

import CoreData

struct User: Decodable, ModelCoreData {
    let id: Int
    let name: String
    let email: String
    let phone: String
    
    static func getEntity() -> String {
        return String(describing: LocalUser.self)
    }
    
    func getCoreDataDictionary() -> [String : Any?] {
        return ["id": self.id,
                "name": self.name,
                "email": self.email,
                "phone": self.phone]
    }
    
    func getIdentifier() -> Int {
        return id
    }
    
    init(object: NSManagedObject) {
        self.id = object.value(forKey: "id") as? Int ?? 0
        self.name = object.value(forKey: "name") as? String ?? ""
        self.email = object.value(forKey: "email") as? String ?? ""
        self.phone = object.value(forKey: "phone") as? String ?? ""
    }
}
