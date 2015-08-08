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

