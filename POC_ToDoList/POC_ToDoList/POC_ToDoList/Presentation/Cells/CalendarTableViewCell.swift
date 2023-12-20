//
//  CalendarTableViewCell.swift
//  POC_ToDoList
//
//  Created by marilise morona on 19/12/23.
//

import UIKit

protocol CalendarProtocolDelegate: AnyObject {
    func getFullDate(_ date: Date,_ tag: Int)
    
}
class CalendarTableViewCell: UITableViewCell {
    
    weak var delegate: CalendarProtocolDelegate?
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        datePicker.addTarget(self, action: #selector(getValueChangedForDate), for: .valueChanged)
        
    }
    
    @objc func getValueChangedForDate(_ sender: UIDatePicker) {
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        guard let delegate = delegate else { return }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.string(from: selectedDate)
        delegate.getFullDate(datePicker.date, sender.tag)

    }
}
