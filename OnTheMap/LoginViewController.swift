//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Jonathan Kim on 8/7/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.view.endEditing(true)
    }

    //MARK: IBActions
    @IBAction func onLoginButton(sender: UIButton) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(usernameTextField.text)\", \"password\": \"\(passwordTextField.text)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                print(error)
            }
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            println(NSString(data: newData, encoding: NSUTF8StringEncoding))

            var jsonifyError: NSError? = nil
            let jsonDict = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &jsonifyError) as! NSDictionary

            if let registered: AnyObject = jsonDict["account"]?["registered"] {
                if registered as! Bool == true {
                    print("login successful!")
                    self.completeLogin()
                }
            } else {
                self.credentialFailAlert()
            }

        }
        task.resume()
    }

    func completeLogin() {
        dispatch_async(dispatch_get_main_queue(), {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ManagerNavigation") as! UIViewController
            self.presentViewController(controller, animated: true, completion: nil)
        })
    }

    func credentialFailAlert() {
        dispatch_async(dispatch_get_main_queue(), {
            let alertController = UIAlertController(title: "Error", message: "Invalid Credentials", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(okButton)
            self.presentViewController(alertController, animated: true, completion: nil)
        })
    }

    @IBAction func onSignUp(sender: UIButton) {
    }

    @IBAction func onLoginWithFacebook(sender: UIButton) {
    }


    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

