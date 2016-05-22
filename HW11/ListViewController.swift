//
//  ListViewController.swift
//  HW11
//
//  Created by Spade Jack on 5/14/16.
//  Copyright © 2016 galileo.jack. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var changeTimer:NSTimer? = nil
    var imageName:String = "af-"
    var imageNumber:NSInteger = 0
    var yummyDic:Dictionary? = [String: String!]()
    var yummyArray:NSMutableArray = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(imageNameChange), userInfo: nil, repeats: true)
        self.setupNavigationBar()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didEditYummy), name: "NotiDic", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - tableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yummyArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        yummyDic = yummyArray[indexPath.row] as? Dictionary<String, String!>
        cell.textLabel?.text = yummyDic!["title"]
        cell.detailTextLabel?.text = yummyDic!["date"]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let  viewController  = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        viewController.detailInfo = yummyArray[indexPath.row] as? Dictionary<String, String!>
        StatusSingleton.sharedInstance.setupCurrentEditType(.cellType)
        StatusSingleton.sharedInstance.setupSelectRow(indexPath.row)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            self.yummyArray.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    //MARK: - EditYummyDelegate
    func didEditYummy(noti:NSNotification) {
        let dic = noti.userInfo

        if StatusSingleton.sharedInstance.currentEditType() == .cellType{
            
            let selectedRow = StatusSingleton.sharedInstance.currentSelectRow()
            yummyArray.removeObjectAtIndex(selectedRow)
            yummyArray.insertObject(dic!, atIndex: selectedRow)
            self.tableView.reloadData()
        }else{
            yummyArray.insertObject(dic!, atIndex: 0)
            let indexPath = NSIndexPath.init(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    //MARK: - Private
    func imageNameChange() -> Void {
        let name:String = imageName + "\(imageNumber%9)"
        self.imageFadeAnimation(name)
        imageNumber += 1
    }
    
    func imageFadeAnimation(name:String) -> Void {
        
        UIView.animateWithDuration(5.0, delay: 2.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            
            self.showView.image = UIImage(named: name)
            self.showView.alpha = 1
            }, completion: nil)
    }
    
    func setupNavigationBar() -> Void {
        
        let addButton = UIBarButtonItem.init(title: "Add", style: .Plain, target: self, action: #selector(goEditView))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func goEditView() -> Void {
        StatusSingleton.sharedInstance.setupCurrentEditType(.addType)
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("EditRecordViewController") as! EditRecordViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func asignDicToTableView(dic:Dictionary<String, String!>) -> Void {
        
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("RecordTableViewController") as! RecordTableViewController
        
        self.presentViewController(viewController, animated: true, completion: nil)
    }
}




