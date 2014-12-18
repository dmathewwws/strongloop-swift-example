//
//  MasterViewController.swift
//  LoopBack-Example
//
//  Created by Daniel Mathews on 2014-12-07.
//  Copyright (c) 2014 com.red-cedar. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects:[AnyObject] = NSMutableArray()

    let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate!)

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        Utilities.sharedInstance.getDataFromModel("Transactions",completionClosure:{(models: [AnyObject]?, error: NSError?) in
            
            if(models != nil) {
                self.objects = models!
                self.tableView.reloadData()
                println("in success block w/ model \(models)")
            }else{
                println("error!!: \(error?.description)")
            }
            
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as NSDate
            (segue.destinationViewController as DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object = objects[indexPath.row] as? LBModel
        
        var transaction:LBModel.Transactions = LBModel.Transactions(amount: object!["amount"] as String)
        
        cell.textLabel!.text = transaction.amount
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func insertNewObject(sender: AnyObject) {
        
        
        Utilities.sharedInstance.postDataFromModel("Transactions", dict:["amount" : "JJ Bean"],completionClosure:{(models: String?, error: NSError?) in
            
            if(models != nil) {
                println("in success block w/ model \(models)")
            }else{
                println("error!!: \(error?.description)")
            }
            
        })
        
        /*      objects.insertObject(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic) */
    }

}
