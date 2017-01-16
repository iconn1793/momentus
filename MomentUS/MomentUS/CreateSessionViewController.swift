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

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inviteFriendsSegue" {
            if let nextVC = segue.destination as? ActiveSessionViewController {
                let sessionName = sessionNameTextField.text!
                if !sessionName.isEmpty {
                    nextVC.sessionName = sessionName
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
