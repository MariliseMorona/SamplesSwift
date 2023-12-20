//
//  InsertInfoTableViewCell.swift
//  POC_ToDoList
//
//  Created by marilise morona on 19/12/23.
//

import UIKit

protocol InsertInfoDelegate: AnyObject {
    func textFieldDidEndEditing(_ textField: UITextField)
}

class InsertInfoTableViewCell: UITableViewCell {
    
    weak var delegate: InsertInfoDelegate?

  
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        infoTextField.delegate = self

        
    }
}

extension InsertInfoTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let delegate = delegate else { return }
        delegate.textFieldDidEndEditing(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, text.isEmpty {
            textField.backgroundColor = .orange
            textField.resignFirstResponder()
            return true
        } else {
            textField.backgroundColor = .purpleApp
            textField.resignFirstResponder()
            return true
        }
    return false
    }
}
