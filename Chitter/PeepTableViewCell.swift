//
//  PeepTableViewCell.swift
//  Chitter
//
//  Created by Sivan Patel on 26/08/2015.
//  Copyright (c) 2015 Sivan Patel. All rights reserved.
//

import UIKit

class PeepTableViewCell: UITableViewCell {

  @IBOutlet weak var usernameLabel: UILabel! = UILabel()
  
  @IBOutlet weak var timestampLabel: UILabel! = UILabel()
  
  
  @IBOutlet weak var peepTextView: UITextView! = UITextView()
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
