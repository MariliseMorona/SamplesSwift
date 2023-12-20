//
//  ScheculedItemTableViewCell.swift
//  POC_ToDoList
//
//  Created by marilise morona on 19/12/23.
//

import UIKit

class ScheculedItemTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
