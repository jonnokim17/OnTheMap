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
        static let ParseBaseURL: String = "https://api.parse.com/1/classes/"
        static let ParseApplicationID: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ParseRESTAPIKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }

    struct Methods {
        static let Session = "session"
        static let UserData =  "users/{id}"
        static let ParseMethod = "StudentLocation"
    }

    // MARK: - URL Keys
    struct URLKeys {
        static let UserID = "id"
    }

    // MARK: - Parameter Keys
    struct ParameterKeys {

        static let limit = "100"
        static let skip = "400"
        static let order = "updatedAt"

    }

    // MARK: - JSON Response Keys
    struct JSONResponseKeys {

        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
    }
}
