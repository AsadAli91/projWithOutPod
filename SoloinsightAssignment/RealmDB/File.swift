//
//  File.swift
//  TillerStackiOS
//
//  Created by Epazz on 16/06/2022.
//
import Foundation
import UIKit
import RealmSwift

protocol LocalStorageProtocol {
    func object<T: Object>() -> T?
    func object<T: Object>(_ key: Any?) -> T?
    func object<T: Object>(_ predicate: (T) -> Bool) -> T?
    
    func objects<T: Object>() -> [T]
    func objects<T: Object>(_ predicate: (T) -> Bool) -> [T]
    
    @discardableResult func write<T: Object>(_ object: T?) -> Bool
    @discardableResult func write<T: Object>(_ objects: [T]?) -> Bool
    
    @discardableResult func update(_ block: () -> ()) -> Bool
    @discardableResult func delete<T: Object>(_ object: T) -> Bool
//    @discardableResult func deleteObj <T: Object> (_ obj : T)
    
    @discardableResult func flush() -> Bool
}

class realmDB: LocalStorageProtocol {
    fileprivate var realm: Realm? {
        do {
            return try Realm()
        } catch let error {
            let nsError: NSError = error as NSError
            if nsError.code == 10 {
                guard let defaultPath: URL = Realm.Configuration.defaultConfiguration.fileURL else { return nil }
                try? FileManager.default.removeItem(at: defaultPath)
                return self.realm
            }
            print("Default realm init failed: ", error)
        }
        return nil
    }
    
    func object<T: Object>() -> T? {
        let key: AnyObject = 0 as AnyObject
        return self.object(key)
    }
    
    func object<T: Object>(_ key: Any?) -> T? {
        guard let key: Any = key else { return nil }
        guard let realm: Realm = self.realm else { return nil }
        guard let object: T = realm.object(ofType: T.self, forPrimaryKey: key) else { return nil }
        return !object.isInvalidated ? object : nil
    }
    
    func object<T: Object>(_ predicate: (T) -> Bool) -> T? {
        guard let realm: Realm = self.realm else { return nil }
        return realm.objects(T.self).filter(predicate).filter({ !$0.isInvalidated }).first
    }
    
    func objects<T: Object>() -> [T] {
        guard let realm: Realm = self.realm else { return [] }
        return realm.objects(T.self).filter({ !$0.isInvalidated })
    }
    
    func objects<T: Object>(_ predicate: (T) -> Bool) -> [T] {
        guard let realm: Realm = self.realm else { return [] }
        return realm.objects(T.self).filter(predicate).filter({ !$0.isInvalidated })
    }
    
    func write<T: Object>(_ object: T?) -> Bool {
        guard let object: T = object else { return false }
        guard let realm: Realm = self.realm else { return false }
        guard !object.isInvalidated else { return false }
        
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
            return true
        } catch let error {
            print("Writing failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
    
//    func write<T: Object>(_ object: T? , _ index :Int) -> Bool {
//        guard let object: T = object else { return false }
//        guard let realm: Realm = self.realm else { return false }
//        guard !object.isInvalidated else { return false }
//        
//        do {
//            try realm.write {
//                realm.add(object, update: .all)
//            }
//            return true
//        } catch let error {
//            print("Writing failed for ", String(describing: T.self), " with error ", error)
//        }
//        return false
//    }
    
    
    
    func write<T: Object>(_ objects: [T]?) -> Bool {
        guard let objects: [T] = objects else { return false }
        guard let realm: Realm = self.realm else { return false }
        let validated: [T] = objects.filter({ !$0.isInvalidated })
        do {
            try realm.write {
                realm.add(validated, update: .all)
            }
            return true
        } catch let error {
            print("Writing of array failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
    
    func update(_ block: () -> ()) -> Bool {
        guard let realm: Realm = self.realm else { return false }
        do {
            try realm.write(block)
            return true
        } catch let error {
            print("Updating failed with error ", error)
        }
        return false
    }
    
//    func deleteObj <T: Object> (_ obj : T){
//        do {
//            try realmObj.write {
//                realmObj.delete(obj)
//
//            }
//        }catch {
//            print("DbHelperException","Delete",error)
//        }
//
//    }
    
    func delete<T: Object>(_ object: T) -> Bool {
        guard let realm: Realm = self.realm else { return false }
        guard !object.isInvalidated else { return true }
        do {
            try realm.write {
                realm.delete(object)
            }
            return true
        } catch let error {
            print("Writing of array failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
    
    func flush() -> Bool {
        guard let realm: Realm = self.realm else { return false }
        
        do {
            try realm.write {
                 //realm.delete(realm.objects(OrderModelRealm.self))
            }
            return true
        } catch let error {
            print("Databse flush failed with ", error)
        }
        return false
    }

    func fetchData<T: Object>(_ objectType: T.Type, _ predicate: NSPredicate ) -> [T] {
        guard let realm: Realm = self.realm else { return [] }
        let data = Array(realm.objects(T.self).filter(predicate))
        return data
    }
    
    func fetchData<T: Object>(_ objectType: T.Type) -> [T] {
        guard let realm: Realm = self.realm else { return [] }
        let data = Array(realm.objects(T.self))
        return data
    }
    
    
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
//let realm = try! Realm()
//for item in realm.objects(OrderModelRealm.self).filter("mechanicId == %@", session.user?.mechanicID ?? "") {
//    print("item from db = \(item)")
//}
