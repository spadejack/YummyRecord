//
//  RecordTableViewController.swift
//  HW11
//
//  Created by Spade Jack on 5/14/16.
//  Copyright © 2016 galileo.jack. All rights reserved.
//

import UIKit

class RecordTableViewController: UITableViewController {

    var diaryArray:NSMutableArray? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryArray = NSMutableArray()
        self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var arrayCount:Int = (diaryArray?.count)!
        
        if diaryArray?.count == nil {
            return 0
        }else{
            return arrayCount
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath)
        var dic = diaryArray?.objectAtIndex(indexPath.row)
        
        return cell
    }
}








