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

    // MARK: - Shared Instance

    class func sharedInstance() -> UdacityClient {

        struct Singleton {
            static var sharedInstance = UdacityClient()
        }

        return Singleton.sharedInstance
    }

    //MARK: GET
    func taskForLogin(method: String, userEmail: String, password: String, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {

        let urlString = Constants.BaseURL + method
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(userEmail)\", \"password\": \"\(password)\"}}".dataUsingEncoding(NSUTF8StringEncoding)

        let task = session.dataTaskWithRequest(request) {data, response, downloadError in

            if let error = downloadError {
                let newError = UdacityClient.errorForData(data, response: response, error: error)
                completionHandler(result: nil, error: downloadError)
            } else {
                let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
                UdacityClient.parseJSONWithCompletionHandler(newData, completionHandler: completionHandler)
            }
        }
        task.resume()

        return task
    }

    func taskForStudentLocation(method: String, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {

        let methodParameters = [
            "limit" : ParameterKeys.limit,
//            "skip" : ParameterKeys.skip,
//            "order" : ParameterKeys.order
        ]

        let urlString = Constants.ParseBaseURL + method + UdacityClient.escapedParameters(methodParameters)
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        var jsonifyError: NSError? = nil
        request.addValue(Constants.ParseApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(Constants.ParseRESTAPIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")

        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            if let error = downloadError {
                let newError = UdacityClient.errorForData(data, response: response, error: error)
                completionHandler(result: nil, error: downloadError)
            } else {
                UdacityClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
            }
        }

        task.resume()

        return task
    }

    class func substituteKeyInMethod(method: String, key: String, value: String) -> String? {
        if method.rangeOfString("{\(key)}") != nil {
            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
        } else {
            return nil
        }
    }

    /* Helper: Given a response with error, see if a status_message is returned, otherwise return the previous error */
    class func errorForData(data: NSData?, response: NSURLResponse?, error: NSError) -> NSError {

        if let parsedResult = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as? [String : AnyObject] {

            if let errorMessage = parsedResult[JSONResponseKeys.StatusMessage] as? String {

                let userInfo = [NSLocalizedDescriptionKey : errorMessage]

                return NSError(domain: "Udacity Error", code: 1, userInfo: userInfo)
            }
        }

        return error
    }

    /* Helper: Given raw JSON, return a usable Foundation object */
    class func parseJSONWithCompletionHandler(data: NSData, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {

        var parsingError: NSError? = nil

        let parsedResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)! as! NSDictionary

        if let error = parsingError {
            completionHandler(result: nil, error: error)
        } else {
            completionHandler(result: parsedResult, error: nil)
        }
    }

    /* Helper function: Given a dictionary of parameters, convert to a string for a url */
    class func escapedParameters(parameters: [String : AnyObject]) -> String {

        var urlVars = [String]()

        for (key, value) in parameters {

            /* Make sure that it is a string value */
            let stringValue = "\(value)"

            /* Escape it */
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())

            /* Append it */
            urlVars += [key + "=" + "\(escapedValue!)"]

        }

        return (!urlVars.isEmpty ? "?" : "") + join("&", urlVars)
    }
}
