//
//  ChatTableViewCell.swift
//  DFSampleUI
//
//  Created by Santhosh Vaddi on 1/20/19.
//  Copyright © 2019 Santhosh Vaddi. All rights reserved.
//

import UIKit
import MaterialComponents

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var selfCardView: MDCCard!
    @IBOutlet weak var selfText: UILabel!
    @IBOutlet weak var botCardView: MDCCard!
    @IBOutlet weak var botResponseText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selfCardView?.cornerRadius = selfCardView.frame.height/2
        botCardView?.cornerRadius = botCardView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
