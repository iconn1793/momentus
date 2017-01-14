//
//  GlobalTypealiases .swift
//  MomentUS
//
//  Created by Ian Connelly on 1/14/17.
//  Copyright © 2017 Ian Connelly. All rights reserved.
//

import Foundation

internal let SERIAL_QUEUE = DispatchQueue(label: "com.EconnHackathon.serial_queue")

internal func runOnSerialQueue(block: @escaping ()->Void) {
    SERIAL_QUEUE.async {
        block()
    }
}
