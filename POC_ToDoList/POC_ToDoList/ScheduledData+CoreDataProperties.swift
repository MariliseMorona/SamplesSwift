//
//  ScheduledData+CoreDataProperties.swift
//  POC_ToDoList
//
//  Created by marilise morona on 20/12/23.
//
//

import Foundation
import CoreData


extension ScheduledData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScheduledData> {
        return NSFetchRequest<ScheduledData>(entityName: "ScheduledData")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: Date?

}

extension ScheduledData : Identifiable {

}
