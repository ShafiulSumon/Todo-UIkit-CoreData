//
//  TaskTVC.swift
//  Todo
//
//  Created by ShafiulAlam-00058 on 6/11/24.
//

import UIKit


class TaskTVC: UITableViewCell {

    @IBOutlet weak var taskDateLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var boxView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
