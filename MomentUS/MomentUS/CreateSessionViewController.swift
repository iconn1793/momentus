//
//  CreateSessionViewController.swift
//  MomentUS
//
//  Created by Eric Connelly on 1/15/17.
//  Copyright © 2017 Ian Connelly. All rights reserved.
//

import UIKit

class CreateSessionViewController: UIViewController, UITextFieldDelegate {
    //MARK: Properties
    @IBOutlet weak var sessionNameTextField: UITextField!

    //MARK: UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field's user input through delegate callbacks
        sessionNameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
