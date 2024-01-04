//
//  Persistence.swift
//  GTFoodPin
//
//  Created by Augus Venn on 2024/1/3.
//

import Foundation
import CoreData
import UIKit

struct PersistenceController {
    
    static let shared = PersistenceController(inMemory: true)
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "GTFoodPin")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            container.loadPersistentStores { storeDescription, error in
                if let error = error as NSError? {
                    print("Core data failed to load: \(error.localizedDescription)")
                    return
                }
            }
        }
        
        /*
         mergeByPropertyObjectTrump : 一种按单个属性合并对象的持久存储版本与当前内存版本之间冲突的策略，内存中的更改优先于外部更改。
         mergeByPropertyStoreTrump: 一种按单个属性合并对象的持久存储版本与当前内存版本之间冲突的策略，外部更改优先于内存更改。
         */
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    
    static var preview: PersistenceController = {
       
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let restaurant = Restaurant(context: viewContext)
        
        restaurant.name = "Cafe Deadend"
        restaurant.type = "Coffee & Tea Shop"
        restaurant.location = "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong"
        restaurant.phone = "232-923423"
        restaurant.summary = "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."
        restaurant.image = (UIImage(named: "Cafe Deadend")?.pngData())!
        restaurant.isFavorite = false
        
        
        do {
            
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()
    
    
    static var testData: [Restaurant]? = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
        return try? PersistenceController.preview.container.viewContext.fetch(fetchRequest) as? [Restaurant]
    }()
    
}



