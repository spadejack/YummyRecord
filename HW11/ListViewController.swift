//
//  ListViewController.swift
//  HW11
//
//  Created by Spade Jack on 5/14/16.
//  Copyright © 2016 galileo.jack. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, EditYummyDelegate{

    var changeTimer:NSTimer? = nil
    var imageName:String = "af-"
    var imageNumber:NSInteger = 0
    var yummyDic:Dictionary? = [String: String]()
    var recordTableViewController:RecordTableViewController?
    
    
    @IBOutlet weak var showView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RecordTableViewController") as! RecordTableViewController
        recordTableViewController?.tableView.reloadData()
        changeTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(imageNameChange), userInfo: nil, repeats: true)
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - EditYummyDelegate
    func didEditYummy(dic: Dictionary<String, String!>) {

        recordTableViewController?.diaryArray?.addObject(dic)
        recordTableViewController?.tableView.reloadData()
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




