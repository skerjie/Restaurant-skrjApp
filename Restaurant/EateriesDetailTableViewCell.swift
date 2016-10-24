//
//  EateriesDetailTableViewCell.swift
//  Eateries
//
//  Created by Andrei Palonski on 24.10.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class EateriesDetailTableViewCell: UITableViewCell {

  @IBOutlet weak var keyLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
