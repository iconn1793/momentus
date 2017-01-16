//
//  CreateSessionViewController.swift
//  MomentUS
//
//  Created by Eric Connelly on 1/15/17.
//  Copyright © 2017 Ian Connelly. All rights reserved.
//

import UIKit

class CreateSessionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    //MARK: Properties
    @IBOutlet weak var sessionNameTextField: UITextField!
    @IBOutlet weak var friendsTableView: UITableView!
    private var friends = [Friend]()

    //MARK: Private methods
    private func _createFriend(_ name: String) -> Friend {
        let photoIcon = UIImage(named: "defaultPerson")
        guard let friend = Friend(name: name, profileImage: photoIcon) else {
            fatalError("Unable to instantiate friend")
        }
        return friend
    }
    private func _loadInitialFriends() {
        friends += [_createFriend("Eric Connelly")]
        friends += [_createFriend("Jake Horenstein")]
        friends += [_createFriend("Jason Rose")]
        friends += [_createFriend("Scott Connelly")]
        friends += [_createFriend("Ian Connelly")]
        friends += [_createFriend("Daniel David")]
        friends += [_createFriend("Jesse Ruben")]
    }

    private func _getInvitedFriends() -> [Friend] {
        var invitedFriends = [Friend]()
        for friend in friends {
            if (friend.isInvited) {
                invitedFriends += [friend]
            }
        }
        return invitedFriends
    }

    //MARK: UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        _loadInitialFriends()
        // Handle the friend tableView through delegate callbacks
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        // Handle the text field's user input through delegate callbacks
        sessionNameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITableViewController Methods

    func numberOfSections(in tableView: UITableView) -> Int {
        // Only 1 section: for Friends
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FriendTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendTableViewCell else {
            fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
        }

        // Fetches the appropriate instance for the data source layout.
        let friend = friends[indexPath.row]

        // Configure the cell...
        cell.name.text = friend.name
        cell.profileImage.image = friend.profileImage
        cell.isFriendInvited.isOn = friend.isInvited

        // Add a target to handle "invite" switch toggle event
        cell.isFriendInvited.addTarget(
            friend,
            action: #selector(Friend.inviteFriend),
            for: UIControlEvents.valueChanged
        )

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inviteFriendsSegue" {
            if let nextVC = segue.destination as? ActiveSessionViewController {
                // Set Session Title
                let sessionName = sessionNameTextField.text!
                if !sessionName.isEmpty {
                    nextVC.sessionName = sessionName
                }

                // Set the invited friends
                print("Number of friends selected?")
                nextVC.friends = _getInvitedFriends()
            }
        }
    }

    //MARK: UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        sessionNameTextField.text = textField.text
    }
}
