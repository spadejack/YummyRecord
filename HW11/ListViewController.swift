//
//  ListViewController.swift
//  HW11
//
//  Created by Spade Jack on 5/14/16.
//  Copyright © 2016 galileo.jack. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, EditYummyDelegate, UITableViewDelegate, UITableViewDataSource{

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
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    //MARK: - EditYummyDelegate
    func didEditYummy(dic: Dictionary<String, String!>) {

        yummyArray.addObject(dic)
        self.tableView.reloadData()
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
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("EditRecordViewController") as! EditRecordViewController
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func asignDicToTableView(dic:Dictionary<String, String!>) -> Void {
        
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("RecordTableViewController") as! RecordTableViewController
        
        self.presentViewController(viewController, animated: true, completion: nil)
    }
}




