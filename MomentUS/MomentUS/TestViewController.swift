//
//  ViewController.swift
//  MomentUS
//
//  Created by Ian Connelly on 1/14/17.
//  Copyright © 2017 Ian Connelly. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var _statusLabel: UILabel!
    @IBOutlet weak var _testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _updateButtonUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI Updates
    
    private func _updateButtonUI() {
        _testButton.setTitle("Listen", for: .normal)
        _testButton.layer.cornerRadius = 5
        _testButton.contentEdgeInsets = UIEdgeInsetsMake(5, 30, 5, 30)
    }
    
    private func _updateLabelText(newText: String) {
        _statusLabel.text = newText
    }
    
    private func _listenForLockScreenChange() {
        
    }
    
    // MARK: - Actions

    @IBAction func testButtonAction() {
        _updateLabelText(newText: "Im listening!")
    }

}

