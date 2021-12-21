//
//  CoreDataManager.swift
//  Tasks
//
//  Created by Shahrukh on 14/12/2021.
//  Copyright © 2021 Programmer Force. All rights reserved.
//
import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "TaskDataModel")
        persistentContainer.loadPersistentStores(completionHandler: {
            (description, error) in
            
            if let error = error{
                fatalError("Core data Store failed\(error.localizedDescription)")
            }
        })
    }
    
    //save task
    func saveItem(id: String, todo: String) {
        let item = TodoItem(context: persistentContainer.viewContext)
        item.todoItem = todo
        
        do {
            try persistentContainer.viewContext.save()
        } catch  {
            print("Failed to save task \(error)")
        }
    }
    
    //get all tasks
    func getAllItems() -> [TodoItem] {
        
        let fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch  {
            return []
        }
    }
    //Delete task
    func deleteItem(item: TodoItem) {
        
        persistentContainer.viewContext.delete(item)
        
        do {
            try persistentContainer.viewContext.save()
        } catch  {
            print("Failed to delete task \(error)")
        }
    }
    
    // Update task
    func updateItem(taskToUpdate: TodoItem, isDone: Bool) {
        
        taskToUpdate.isDone = isDone
        
        do {
            
            try persistentContainer.viewContext.save()
        } catch  {
            print("Failed to update task \(error)")
        }
    }
}

