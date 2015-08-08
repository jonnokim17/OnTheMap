//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Jonathan Kim on 8/7/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

import UIKit

class UdacityClient: NSObject {
    /* Shared session */
    var session: NSURLSession

    /* Authentication state */
    var sessionID : String? = nil

    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }

    //MARK: GET
}
