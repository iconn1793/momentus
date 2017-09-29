//
//  HomeViewController.swift
//  MomentUS
//
//  Created by Eric Connelly on 9/29/17.
//  Copyright © 2017 Ian Connelly. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: UIViewController Methods
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
