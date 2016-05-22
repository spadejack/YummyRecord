//
//  StatusSingleton.swift
//  HW11
//
//  Created by Spade Jack on 5/22/16.
//  Copyright © 2016 galileo.jack. All rights reserved.
//

import UIKit

class StatusSingleton: NSObject {

    static let sharedInstance = StatusSingleton()
    var editType:EditType?
    var selectedRow:NSInteger? = 0
    
    func currentEditType() -> EditType {
        return editType!
    }
    
    func setupCurrentEditType(type:EditType) -> Void {
        editType = type
    }

    func currentSelectRow() -> NSInteger {
        return selectedRow!
    }
    
    func setupSelectRow(row:NSInteger) -> Void {
        selectedRow! = row
    }
}
