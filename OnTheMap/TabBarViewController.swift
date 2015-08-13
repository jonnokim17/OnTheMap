//
//  TabBarViewController.swift
//  OnTheMap
//
//  Created by Jonathan Kim on 8/12/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

import UIKit

protocol TabBarViewControllerDelegate {
    func tabBarRefresh()
}

class TabBarViewController: UITabBarController {

    var tabBarVCDelegate: TabBarViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshBarButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "onRefresh")

        var button: UIButton = UIButton()
        button.setImage(UIImage(named: "pin"), forState: .Normal)
        button.frame = CGRectMake(0, 0, 45, 45)
        button.addTarget(self, action: "onPinButton", forControlEvents: UIControlEvents.TouchUpInside)

        var pinButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItems = [refreshBarButton, pinButton]
    }

    func onRefresh() {
        tabBarVCDelegate?.tabBarRefresh()
    }

    func onPinButton() {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: UIBarButtonItem) {
        UdacityClient.sharedInstance().taskForLoggingOut(UdacityClient.Methods.Session, completionHandler: { (result, error) -> Void in
            if (error == nil) {
                var parseResult: NSDictionary = result as! NSDictionary
                if self.containsKey(parseResult, key: "session") {
                    print("Logged out successfully!")
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    print("Error logging out")
                }
                print(result)
            }
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
}
