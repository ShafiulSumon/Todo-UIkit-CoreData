//
//  TodoList+CoreDataProperties.swift
//  Todo
//
//  Created by ShafiulAlam-00058 on 6/11/24.
//
//

import Foundation
import CoreData


extension TodoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoList> {
        return NSFetchRequest<TodoList>(entityName: "TodoList")
    }

    @NSManaged public var name: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var date: Date?

}

extension TodoList : Identifiable {

}
