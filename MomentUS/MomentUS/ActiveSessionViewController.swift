//
//  ViewController.swift
//  MomentUS
//
//  Created by Ian Connelly on 1/14/17.
//  Copyright © 2017 Ian Connelly. All rights reserved.
//

import UIKit

let LockStateChangedNotification = Notification.Name(rawValue: "lock_state_changed")

class ActiveSessionViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var sessionNameTextField: UILabel!
    @IBOutlet weak var _beginButton: UIButton!
    @IBOutlet weak var friendsTableView: UITableView!
    private var friends = [Friend]()
    var sessionName = "Session Name"
    
    private var isUnplugSessionInProgress = false
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

    //MARK: Controller state change handling logic
    override func viewDidLoad() {
        super.viewDidLoad()
        sessionNameTextField.text = sessionName
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_onAppEnterBackground),
            name: NSNotification.Name.UIApplicationDidEnterBackground,
            object: nil
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func _listenForDeviceActivity() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_updateLockScreenStatus),
            name: LockStateChangedNotification,
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
                            name: LockStateChangedNotification
                        )
                    )
            },
            //"com.apple.iokit.hid.displayStatus" as CFString!,
            //"com.apple.springboard.lockcomplete" as CFString!,
            "com.apple.springboard.lockstate" as CFString!,
            //"com.apple.springboard.hasBlankedScreen" as CFString!,
            nil,
            CFNotificationSuspensionBehavior.deliverImmediately
        )
    }

    private func _stopListeningForDeviceActivity() {
        NotificationCenter.default.removeObserver(
            self,
            name: LockStateChangedNotification,
            object: nil)
    }

    @objc func _onAppEnterBackground() {
        print("Say... app entered background")
    }

    @objc func _updateLockScreenStatus() {
        self.phoneIsLocked = !self.phoneIsLocked
        if self.phoneIsLocked {
            print("Phone is now locked.")
        } else {
            print("Phone is now unlocked.")
        }
    }
    
    // MARK: - UI Updates

    private func _updateButtonText(newText: String) {
        _beginButton.setTitle(newText, for: .normal)
    }


    // MARK: - Controller Actions
    private func startUnpluggedEvent() {
        isUnplugSessionInProgress = true
        _updateButtonText(newText: "End Unplugged Session")
        print("listening for Lock/Unlock events...")

        _listenForDeviceActivity()
    }

    private func endUnpluggedEvent() {
        isUnplugSessionInProgress = false
        _updateButtonText(newText: "Create New Session")
        print("stop listening...")

        _stopListeningForDeviceActivity()
    }

    // MARK: - User Actions
    @IBAction func toggleUnplugSession() {
        if (isUnplugSessionInProgress) {
            endUnpluggedEvent()
        } else {
            startUnpluggedEvent()
        }
    }

}



