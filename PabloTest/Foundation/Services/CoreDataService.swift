//
//  CoreDataService.swift
//  PabloTest
//
//  Created by Pablo Duarte on 12/12/21.
//

import UIKit
import CoreData

protocol ModelCoreData {
    static func getEntity() -> String
    func getCoreDataDictionary() -> [String:Any?]
    func getIdentifier() -> Int
    init(object: NSManagedObject)
}

class CoreDataService {
    static let shared = CoreDataService()

    func create<T:ModelCoreData>(_ model: T, save: Bool = true) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: type(of: model).getEntity(), in: managedContext)!
        let dic = model.getCoreDataDictionary()
        let keys = Array.init(dic.keys)
        let model = NSManagedObject(entity: entity, insertInto: managedContext)
        
        for k in keys {
            if dic[k]! != nil {
                model.setValue(dic[k]!, forKey: k)
            }
        }
        if !save{
            return
        }
        do {
            try managedContext.save()
        } catch {
            print("Could not save. \(error), \(error.localizedDescription)")
        }
    }
    
    func create<T:ModelCoreData>(_ models: [T]) {
        for (i,m) in models.enumerated() {
            if i == (models.count - 1) {
                create(m, save: true)
                return
            }
            create(m, save: false)
        }
    }
    
    func retrieve<T:ModelCoreData>(_ clase: T.Type) -> [T] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: clase.getEntity())
        do {
            let result = try managedContext.fetch(fetchRequest)
            var list:[T] = []
            for data in result as! [NSManagedObject] {
                list.append(clase.init(object: data))
            }
            return list
        } catch {
            print("Failed")
        }
        return []
    }
}
