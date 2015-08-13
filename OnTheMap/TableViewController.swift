//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Jonathan Kim on 8/12/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var studentArray: NSMutableArray!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let barVCs = self.tabBarController?.viewControllers
        let mapVC = barVCs![0] as! MapViewController
        studentArray = mapVC.studentArray!
    }

    override func viewDidLayoutSubviews() {
        if let var rect = self.navigationController?.navigationBar.frame {
            var y = rect.size.height + rect.origin.y
            self.tableView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        cell.imageView?.image = UIImage(named: "pin")

        var student: Student = studentArray[indexPath.row] as! Student
        cell.textLabel?.text = student.firstName

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentArray.count
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedStudent = studentArray[indexPath.row] as! Student
        var urlString = selectedStudent.mediaURL
        var url = NSURL(string: urlString)

        if url != nil {
            UIApplication.sharedApplication().openURL(url!)
        } else {
            print("\(selectedStudent.firstName) does not have URL")
        }
    }
}
