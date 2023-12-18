//
//  CategoriesRepository.swift
//  POCStoryboard_AppScheduled
//
//  Created by marilise morona on 18/12/23.
//

import UIKit

enum CategoryType {
    case study
    case worked
    case home
    
    func retornedNameForCategory(category: CategoryType) -> String {
        switch self {
        case .study:
            return "Study"
        case .worked:
            return "Worked"
        case .home:
            return "Home"
        }
    }
    
    func retornerColorForCategory(category: CategoryType) -> UIColor {
        switch self {
        case .study:
            return ColorCategory.green.color
        case .worked:
            return ColorCategory.blue.color
        case .home:
            return ColorCategory.yellow.color
        }
    }
    
    static func getCategories() -> [Category] {
        let categories = [
            Category(categoryType: .study),
            Category(categoryType: .worked),
            Category(categoryType: .home)
        ]
        
        return categories
    }
}

enum ColorCategory {
    case black
    case blue
    case green
    case pink
    case yellow
    
    var color: UIColor {
        switch self {
        case .black:
            return UIColor.black
        case .blue:
            return UIColor.blue
        case .green:
            return UIColor.green
        case .pink:
            return UIColor.systemPink
        case .yellow:
            return UIColor.yellow
        }
    }
}
