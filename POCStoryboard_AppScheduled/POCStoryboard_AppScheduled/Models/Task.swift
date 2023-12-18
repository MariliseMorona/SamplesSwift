//
//  Task.swift
//  POCStoryboard_AppScheduled
//
//  Created by marilise morona on 15/12/23.
//

import UIKit

struct Task {
    var id = UUID()
    var name: String = ""
    var date: Date = Date()
    var category: Category = Category()
}
