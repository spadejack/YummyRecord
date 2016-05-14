//
//  EditRecordViewController.swift
//  HW11
//
//  Created by Spade Jack on 5/14/16.
//  Copyright © 2016 galileo.jack. All rights reserved.
//

import UIKit

protocol EditYummyDelegate:class {
    func didEditYummy(dic:Dictionary<String, String!>) -> Void
}

class EditRecordViewController: UIViewController {

    var dic:Dictionary = [String: String!]()
    var delegate:EditYummyDelegate?
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var introTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Pivate 
    func setupNavigation() -> Void {
        
        let doneButton = UIBarButtonItem.init(title: "Done", style: .Done, target: self, action: #selector(doneClick))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func doneClick() -> Void {
        let dicTemp = ["title":titleTF!.text ,"date": dateTF!.text, "intro": introTextView!.text]
        dic = dicTemp
        self.delegate?.didEditYummy(dic)
        self.navigationController?.popViewControllerAnimated(true)
    }
}




