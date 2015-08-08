//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Jonathan Kim on 8/8/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

extension UdacityClient {

    //MARK: Constants
    struct Constants {
        static let BaseURL : String = "https://www.udacity.com/api/"
    }

    struct Methods {
        static let Session = "session"
        static let UserData =  "users/{id}"
    }

    // MARK: - URL Keys
    struct URLKeys {
        static let UserID = "id"
    }

    // MARK: - JSON Response Keys
    struct JSONResponseKeys {

        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
    }
}
