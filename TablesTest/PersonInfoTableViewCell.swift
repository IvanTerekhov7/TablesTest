//
//  PersonInfoTableViewCell.swift
//  TablesTest
//
//  Created by Ivan Terekhov on 11.07.2023.
//

import UIKit

class PersonInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
