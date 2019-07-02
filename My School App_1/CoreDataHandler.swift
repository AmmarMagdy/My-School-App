//
//  CoreDataHandler.swift
//  My School App_1
//
//  Created by Afnan on 6/29/19.
//

import Foundation
import CoreData
import UIKit

class CoreDataHandler: NSObject {
    
    static func getCoreDataObject () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // object from App Delegate
        return appDelegate.persistentContainer.viewContext // object from Core Data
    }
    
    static func saveIntoCoreData (student:StudentInfo) {
        let context = getCoreDataObject()
       
        do {
        try context.save()
            print("Saved")
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    static func getAllCoreDataInfo () -> [StudentInfo] {
        let context = getCoreDataObject()
        var studentInfo = [StudentInfo]()
        
        do {
       studentInfo = try context.fetch(StudentInfo.fetchRequest())
        } catch (let error) {
            print(error.localizedDescription)
        }
        return studentInfo
    }
    
    static func deleteCoreDataItem (student:StudentInfo) -> [StudentInfo] {
        let context = getCoreDataObject()
        context.delete(student)
        
        do {
            try context.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
        
        return getAllCoreDataInfo()
    }
}
