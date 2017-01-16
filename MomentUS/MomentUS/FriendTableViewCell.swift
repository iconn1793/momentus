//
//  FriendTableViewCell.swift
//  MomentUS
//
//  Created by Eric Connelly on 1/15/17.
//  Copyright © 2017 Ian Connelly. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var isFriendInvited: UISwitch!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class InviteeTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var hasJoined: UISwitch!

}
