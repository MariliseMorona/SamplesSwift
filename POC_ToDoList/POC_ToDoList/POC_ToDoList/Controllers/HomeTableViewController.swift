//
//  HomeTableViewController.swift
//  POC_ToDoList
//
//  Created by marilise morona on 19/12/23.
//

import UIKit
import CoreData

struct ScheduledItem {
    var title: String = ""
    var hour: String = ""
    var date: String = ""
}

class HomeTableViewController: UITableViewController {
    
    var container: PersistentContainer = PersistentContainer()
    
    var scheduleds = [ScheduledItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard container != nil else {
            fatalError("This view needs a persistent container.")
        }
        scheduleds = container.retriveContext()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVc = segue.destination as? CreateTaskTableViewController {
            nextVc.container = container
        }
    }
    
    @IBAction func tappedToCreateTast(_ sender: Any) {
        let segueIdentifier = "createTask"
           performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scheduleds.isEmpty {
            return 1
        } else {
            return scheduleds.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if scheduleds.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheculedItemTableViewCell", for: indexPath) as! ScheculedItemTableViewCell
            cell.titleLabel.text = scheduleds[indexPath.row].title
            cell.dateLabel.text = scheduleds[indexPath.row].date
            cell.hourLabel.text = scheduleds[indexPath.row].hour
            return cell
        }
    }
}
