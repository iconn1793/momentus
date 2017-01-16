//
//  Friend.swift
//  MomentUS
//
//  Created by Eric Connelly on 1/15/17.
//  Copyright © 2017 Ian Connelly. All rights reserved.
//

import UIKit

class Friend {
    //MARK: Properties
    var name: String
    var profileImage: UIImage?
    var isInvited: Bool
    var hasJoinedSession: Bool

    //MARK: Initialization

    init?(name: String, profileImage: UIImage?) {
        // Initialization should fail if invalid inputs
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        // Initialize stored properties.
        self.name = name
        self.profileImage = profileImage
        self.isInvited = false
        self.hasJoinedSession = false
    }

    @objc func inviteFriend(_ isInvitedSwitch: UISwitch) {
        isInvited = isInvitedSwitch.isOn
    }
}
