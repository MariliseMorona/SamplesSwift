//
//  PersistentContainer.swift
//  POC_ToDoList
//
//  Created by marilise morona on 20/12/23.
//

import CoreData
import UIKit

class PersistentContainer {
    
    let dateFormatter = DateFormatter()
    
    func saveContext(sched: ScheduledItem) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        if let scheduledEntity = NSEntityDescription.entity(forEntityName: "ScheduledData", in: managedContext) {
            let scheduled = NSManagedObject(entity: scheduledEntity, insertInto: managedContext)
            let composableDate = "\(sched.date) \(sched.hour)"
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let newDate = dateFormatter.date(from: composableDate)
            scheduled.setValue(sched.title, forKey: "title")
            scheduled.setValue(newDate, forKey: "date")
            do {
                try managedContext.save()
            } catch {
                print("Could not save \(error), \(error)")
            }
        }
    }
    
    func retriveContext() -> [ScheduledItem] {
        var resultScheduleds = [ScheduledItem]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [ScheduledItem]() }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchResult = NSFetchRequest<NSFetchRequestResult>(entityName: "ScheduledData")
        do {
            let result = try managedContext.fetch(fetchResult)
            
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as! String
                let dateFull = data.value(forKey: "date") as! Date
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let newDate = dateFormatter.string(from: dateFull)
                dateFormatter.dateFormat = "HH:mm"
                let newHour = dateFormatter.string(from: dateFull)
                let newItem = ScheduledItem(title: title, hour: newHour, date: newDate)
                resultScheduleds.append(newItem)
            }
        } catch {
            print("failed retrive")
        }
        return resultScheduleds
    }
    
}
