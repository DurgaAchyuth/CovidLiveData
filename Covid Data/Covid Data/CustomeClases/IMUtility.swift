//
//  IMUtility.swift
//  Corona Data
//
//  Created by Achyuth Bujjigadu  on 04/09/21.
//

import Foundation
import UIKit
import CoreData

struct IMUtility {
    
    static func convertDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let finalDate = dateFormatter.string(from: date!)
        return finalDate
    }
    
    
    static func saveCountryName(saveData: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "CountryNames", in: managedContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(saveData, forKeyPath: "name")
        do {
            try managedContext.save()
            print("SAVED SUCCSFULLY......!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func retrieveData() -> [String] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CountryNames")
    
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let cName = data.value(forKey: "name") as! String
                CDDefaluts.savedCountryNames.append(cName)
            }
        } catch {
            
            print("Failed")
        }
        return CDDefaluts.savedCountryNames
    }
}

