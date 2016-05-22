//
//  DetailViewController.swift
//  HW11
//
//  Created by Spade Jack on 5/15/16.
//  Copyright © 2016 galileo.jack. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailInfo:Dictionary? = [String: String!]()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var introTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTextViewAttri()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = detailInfo!["title"]
        dateLabel.text = detailInfo!["date"]
        introTextView.text = detailInfo!["intro"]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Private Methods
    private func setupNavigationBar() -> Void {
        
        let editBarButton = UIBarButtonItem.init(title: "Edit", style: .Plain, target: self, action: #selector(goEditView))
        self.navigationItem.rightBarButtonItem = editBarButton
    }

    func setupTextViewAttri() -> Void {
        self.introTextView.textColor = UIColor.orangeColor()
    }
    
    func goEditView(index:NSIndexPath) -> Void {
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("EditRecordViewController") as! EditRecordViewController
        viewController.dic = detailInfo!
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}













