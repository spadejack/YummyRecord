//
//  EditRecordViewController.swift
//  HW11
//
//  Created by Spade Jack on 5/14/16.
//  Copyright © 2016 galileo.jack. All rights reserved.
//

import UIKit

class EditRecordViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var dic:Dictionary? = [String: String!]()
    
    @IBOutlet weak var titleTF: UITextField?
    @IBOutlet weak var dateTF: UITextField?
    @IBOutlet weak var introTextView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let detailDic = dic {
            self.titleTF?.text = detailDic["title"]
            self.dateTF?.text = detailDic["date"]
            self.introTextView?.text = detailDic["intro"]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 100:
            dateTF!.becomeFirstResponder()
            print("\(textField.tag)")
        case 101:
            introTextView!.becomeFirstResponder()
            print("\(textField.tag)")
        default:
            break
        }
        return true
    }
    
    func datePickerValueChanged(sender:UIDatePicker) -> Void {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
        dateTF!.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func textFieldEditing(sender: UITextField) {
        
        let datePicker:UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = .Date
        sender.inputView = datePicker
        let dateFormat = NSDateFormatter()
        dateFormat.dateStyle = .MediumStyle
        dateFormat.timeStyle = .NoStyle
        dateTF?.text = dateFormat.stringFromDate(datePicker.date)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), forControlEvents: .ValueChanged)
    }
    
    //MARK: - UITextViewDelegate

    //MARK: - Pivate
    func setupNavigation() -> Void {
        
        let doneButton = UIBarButtonItem.init(title: "Done", style: .Done, target: self, action: #selector(doneClick))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func doneClick() -> Void {
        let dicTemp = ["title":titleTF!.text ,"date": dateTF!.text, "intro": introTextView!.text]
        dic = dicTemp
        NSNotificationCenter.defaultCenter().postNotificationName("NotiDic", object: nil, userInfo: dic)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}




