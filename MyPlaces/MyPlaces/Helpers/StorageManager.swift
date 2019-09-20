//
//  StorageManager.swift
//  MyPlaces
//
//  Created by MacBook on 11/09/2019.
//  Copyright © 2019 MacBook. All rights reserved.
//

import RealmSwift

let realm  = try! Realm()

class StorageManager {
    static func saveObject(_ place: Place) {
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deleteObject (_ place: Place) {
        try! realm.write {
            realm.delete(place)
        }
        
    }
}
