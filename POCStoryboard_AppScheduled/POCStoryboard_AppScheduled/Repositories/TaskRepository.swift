//
//  TaskRepository.swift
//  POCStoryboard_AppScheduled
//
//  Created by marilise morona on 18/12/23.
//

import Foundation


class TaskRepository {
    static let instance: TaskRepository = TaskRepository()
    
    var task: [Task]
    
    private init() {
        self.task = []
    }
    
    func save(task: Task) {
        self.task.append(task)
    }
    
    func update(taskToUpdate: Task) {
        let taskIndex = task.firstIndex(where: { (task) in
            task.id == taskToUpdate.id
        })
        task.remove(at: taskIndex!)
        task.append(taskToUpdate)
    }
    
    func getTasks() -> [Task] {
        return self.task
    }
    
}
