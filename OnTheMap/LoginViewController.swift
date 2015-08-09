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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

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
        activityIndicator.startAnimating()
        UdacityClient.sharedInstance().taskForLogin(UdacityClient.Methods.Session, userEmail: usernameTextField.text, password: passwordTextField.text) { (result, error) -> Void in
            if (error == nil) {
                var parseResult: NSDictionary = result as! NSDictionary
                if self.containsKey(parseResult, key: "account") {
                    self.completeLogin()
                    self.stopActivityIndicator()
                } else {
                    self.credentialFailAlert()
                    self.stopActivityIndicator()
                }
                print(result)
            }
        }
    }

    @IBAction func onSignUp(sender: UIButton) {
    }

    @IBAction func onLoginWithFacebook(sender: UIButton) {
    }

    //MARK: Helpers
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

    func containsKey(dictionary: NSDictionary, key: String) -> Bool {
        var retVal = false
        var allKeys: NSArray = dictionary.allKeys

        if allKeys.containsObject(key) {
            retVal = true
        }
        return retVal
    }

    func stopActivityIndicator() {
        dispatch_async(dispatch_get_main_queue()) {
            self.activityIndicator.stopAnimating()
        }
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

