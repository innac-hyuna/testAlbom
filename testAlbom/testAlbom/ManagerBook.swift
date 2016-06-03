//
//  ManagerBook.swift
//  testAlbom
//
//  Created by FE Team TV on 6/2/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit

class ManagerBook {
    
  var url: NSURL = NSURL()
  var arr = ["Book", "Book1", "Book2", "Book3", "Book4", "Book5", "Book6"]
  var arrList = [(String, NSURL)]()
    
  init() {
    
    for aBook in arr {
        if let path = NSBundle.mainBundle().URLForResource(aBook, withExtension: "pdf", subdirectory: nil, localization: nil) { arrList.append((aBook, path)) }}
  }
    
    
}