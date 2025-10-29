//
//  CoreDataManager.swift
//  BookLibrary
//
//  Created by 김민희 on 10/29/25.
//

import Foundation
import CoreData

class CoreDataManager {
  static let shared = CoreDataManager()
  private init() {}
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "BookLibrary")
    if let description = container.persistentStoreDescriptions.first {
      description.shouldMigrateStoreAutomatically = true
      description.shouldInferMappingModelAutomatically = true
    }
    container.loadPersistentStores { (_, error) in
      if let error = error {
        fatalError("Unresolved error \(error)")
      }
    }
    return container
  }()
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  func saveContext() {
    if context.hasChanges {
      do {
        try context.save()
        print("✅ Core Data 저장 완료")
      } catch {
        print("❌ Core Data 저장 실패: \(error)")
      }
    }
  }
}
