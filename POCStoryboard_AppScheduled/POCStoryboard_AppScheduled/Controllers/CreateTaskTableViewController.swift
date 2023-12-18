//
//  CreateTaskTableViewController.swift
//  POCStoryboard_AppScheduled
//
//  Created by marilise morona on 15/12/23.
//

import UIKit

class CreateTaskTableViewController: UITableViewController {
    
    private let datePicker: UIDatePicker = UIDatePicker()
    private var selectedIndexPath: IndexPath?
    private var dateFormatter: DateFormatter = DateFormatter()
    var task: Task = Task()
    private var taskRepository = TaskRepository.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .dateAndTime
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Task Name"
        case 1:
            return "Category"
        case 2:
            return "Date and Time"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskDescriptionableViewCell", for: indexPath) as! TaskDescriptionableViewCell
            cell.descriptionTextField.delegate = self
            cell.descriptionTextField.text = task.name
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
            cell.categoryLabel.text = task.category.name
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell", for: indexPath) as! DateTableViewCell
            cell.dateTextField.text = dateFormatter.string(from: task.date)
            cell.dateTextField.delegate = self
            cell.dateTextField.inputView = datePicker
            cell.dateTextField.inputAccessoryView = acessoryView()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        taskRepository.save(task: task)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func acessoryView() -> UIView {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        
        let barItemSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(selectedDate))
        
        toolbar.setItems([barItemSpace ,doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        return toolbar
    }
    
    @objc func selectedDate() {
        if let indexPath = self.selectedIndexPath {
            let cell = tableView.cellForRow(at: indexPath) as? DateTableViewCell
            if let dateCell = cell {
                dateCell.dateTextField.text = dateFormatter.string(from: datePicker.date)
                self.view.endEditing(true)
                self.task.date = datePicker.date
                self.tableView.reloadData()
            }
          
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCategoriesTableViewController" {
            let destination = segue.destination as! ChooseCategoryTableViewController
            destination.chooseCatebory = { category in
                self.task.category = category
                self.tableView.reloadData()
            }
        }
    }
}

extension CreateTaskTableViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? DateTableViewCell
        if let dateCell = cell {
            self.selectedIndexPath = tableView.indexPath(for: dateCell)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.superview?.superview is TaskDescriptionableViewCell {
            self.task.name = textField.text!
            self.tableView.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.superview?.superview is TaskDescriptionableViewCell {
            textField.resignFirstResponder()
            return true
        }
        return false
        
    }
}
