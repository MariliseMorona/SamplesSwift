//
//  CreateTaskTableViewController.swift
//  POC_ToDoList
//
//  Created by marilise morona on 19/12/23.
//

import UIKit
import CoreData


protocol CreateTaskDelegate: AnyObject {
    func saveScheduledItem()
}


class CreateTaskTableViewController: UITableViewController {

    weak var container: PersistentContainer?
    weak var delegate: CreateTaskDelegate?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    private var dateFormatter: DateFormatter = DateFormatter()
    private var selectedTagDatePicker: Int = 0
    private var textScheduled: String? = ""
    private var selectedDate: String? = ""
    private var selectedHour: String? = ""
    private var presentToolbar: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        conditionalsforUpdateLayout()
    }
    
    @IBAction func saveScheduled(_ sender: UIBarButtonItem) {
        if let text = textScheduled, !text.isEmpty, let date = selectedDate, !date.isEmpty, let hour = selectedHour, !hour.isEmpty {
            let scheduled = ScheduledItem(title: text, hour: hour, date: date)
            container?.saveContext(sched: scheduled)
        }
    }
    
    private func conditionalsforUpdateLayout() {
        checkIfTheSchedulingFieldsAreEmpty() == false ? (saveButton.tintColor = .purpleApp) : (saveButton.tintColor = .lightGray)
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        conditionalsforUpdateLayout()
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InsertInfoTableViewCell", for: indexPath) as! InsertInfoTableViewCell
            cell.infoTextField.tag = indexPath.row
            cell.delegate = self
            cell.infoTextField.keyboardType = .default
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell", for: indexPath) as! CalendarTableViewCell
            cell.delegate = self
            cell.datePicker.datePickerMode = .date
            cell.datePicker.tag =  indexPath.row
            cell.datePicker.locale = Locale.current
            cell.datePicker.timeZone = .current
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell", for: indexPath) as! CalendarTableViewCell
            cell.delegate = self
            cell.infoLabel.text = "Selecione o horário:"
            cell.datePicker.datePickerMode = .time
            cell.datePicker.tag = indexPath.row
            cell.datePicker.locale = Locale.current
            cell.datePicker.timeZone = .current
            return cell
        default:
            return UITableViewCell()
        }
    }
   
    private func checkIfTheSchedulingFieldsAreEmpty() -> Bool {
        if let text = textScheduled, !text.isEmpty, let date = selectedDate, !date.isEmpty, let hour = selectedHour, !hour.isEmpty {
            saveButton.isEnabled = true
            return false
        }
        saveButton.isEnabled = false
        return true
    }
}

extension CreateTaskTableViewController: InsertInfoDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
       if let text = textField.text, text.isEmpty {
            textScheduled = text
       } else {
           textScheduled = textField.text
       }
        conditionalsforUpdateLayout()
    }
}

extension CreateTaskTableViewController: CalendarProtocolDelegate {

    
    func getFullDate(_ date: Date, _ tag: Int) {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if tag == 1 {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let newDate = dateFormatter.string(from: date)
                selectedDate = newDate
        } else if tag == 2 {
            dateFormatter.dateFormat = "HH:mm"
             let newDate = dateFormatter.string(from: date)
                selectedHour = newDate
            
        }
        conditionalsforUpdateLayout()
    }
}
