//
//  ChooseCategoryTableViewController.swift
//  POCStoryboard_AppScheduled
//
//  Created by marilise morona on 18/12/23.
//

import UIKit

class ChooseCategoryTableViewController: UITableViewController {
    
    let categories = CategoryType.getCategories()
    var chooseCatebory: ((Category) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseCategoryViewCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        self.chooseCatebory!(selectedCategory)
        self.navigationController?.popViewController(animated: true)
    }
}
