//
//  EmptyTableViewCell.swift
//  POC_ToDoList
//
//  Created by marilise morona on 19/12/23.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var imageEmpty: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}
