//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Андрей Фокин on 20.10.21.
//

import UIKit

protocol ToDoCellDalegate {
    func checkmarkTapped(sender: ToDoCell)
}


class ToDoCell: UITableViewCell {
    
    var delegate: ToDoCellDalegate?
    
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var textTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        delegate?.checkmarkTapped(sender: self)
    }
    
    
}
