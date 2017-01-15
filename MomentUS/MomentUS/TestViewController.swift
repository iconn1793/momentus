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
    
    private var lockStateOn = false
    private var phoneIsLocked: Bool {
        get{
            var isLocked: Bool!
            runOnSerialQueue {
                isLocked = self.lockStateOn
            }
            return isLocked
        }
        set{
            runOnSerialQueue {
                self.lockStateOn = newValue
            }
        }
    }
    
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
    
    private func _listenForDeviceActivity() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_updateLockScreenStatus),
            name: Notification.Name(rawValue: "lock_state_changed"),
            object: nil
        )
        
        CFNotificationCenterAddObserver(
            CFNotificationCenterGetDarwinNotifyCenter(),
            nil,
            {
                (
                center: CFNotificationCenter?,
                observer: UnsafeMutableRawPointer?,
                name: CFNotificationName?,
                object: UnsafeRawPointer?,
                info: CFDictionary?) in
                    print("received notification: \(name!)")
                    NotificationCenter.default.post(
                        Notification(
                            name: Notification.Name(rawValue: "lock_state_changed")
                        )
                    )
            },
            "com.apple.springboard.hasBlankedScreen" as CFString!,
            nil,
            CFNotificationSuspensionBehavior.deliverImmediately
        )
        
        /*
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                        nil,
                                        { (center: CFNotificationCenter?, observer: UnsafeMutableRawPointer?, name: CFNotificationName?, object: UnsafeRawPointer?, info: CFDictionary?) in
                                            //self._updateLockScreenStatusMarker()
                                            print("received notification: \(name!)")
                                        },
                                        "com.apple.iokit.hid.displayStatus" as CFString!,
                                        nil,
                                        CFNotificationSuspensionBehavior.deliverImmediately)
        
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                        nil,
                                        { (center: CFNotificationCenter?, observer: UnsafeMutableRawPointer?, name: CFNotificationName?, object: UnsafeRawPointer?, info: CFDictionary?) in
                                            //self._updateLockScreenStatusMarker()
                                            print("received notification: \(name!)")
                                        },
                                        "com.apple.springboard.lockcomplete" as CFString!,
                                        nil,
                                        CFNotificationSuspensionBehavior.deliverImmediately)
        
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                        nil,
                                        { (center: CFNotificationCenter?, observer: UnsafeMutableRawPointer?, name: CFNotificationName?, object: UnsafeRawPointer?, info: CFDictionary?) in
                                            //self._updateLockScreenStatusMarker()
                                            print("received notification: \(name!)")
                                        },
                                        "com.apple.springboard.lockstate" as CFString!,
                                        nil,
                                        CFNotificationSuspensionBehavior.deliverImmediately)
         */
    }
    
    @objc func _updateLockScreenStatus() {
        self.phoneIsLocked = !self.phoneIsLocked
        if self.phoneIsLocked {
            print("Phone is now locked.")
        } else {
            print("Phone is now unlocked.")
        }
        // MARK: - Eric You can add code here!! :) 
    }
    
    // MARK: - Actions

    @IBAction func testButtonAction() {
        _updateLabelText(newText: "Im listening!")
        print("listening...")
        
        _listenForDeviceActivity()
    }

}



