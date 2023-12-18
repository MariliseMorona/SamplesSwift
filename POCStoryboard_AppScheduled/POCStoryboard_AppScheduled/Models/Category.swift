//
//  Category.swift
//  POCStoryboard_AppScheduled
//
//  Created by marilise morona on 15/12/23.
//

import UIKit

struct Category {
    var id = UUID()
    var categoryType: CategoryType = .worked
    var name: String {
        return categoryType.retornedNameForCategory(category: categoryType)
    }
    var color: UIColor {
        return categoryType.retornerColorForCategory(category: categoryType)
    }
}
