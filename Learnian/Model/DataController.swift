//
//  DataController.swift
//  LearnUp
//
//  Created by Vincentius Ian Widi Nugroho on 24/07/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
            
        }
    }
}
