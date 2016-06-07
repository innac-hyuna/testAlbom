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
  var arr = ["Book1", "Book2"]
  var arrList = [(String, String)]()
    
  init() {
    
    for aBook in arr {
        if let path = NSBundle.mainBundle().pathForResource(aBook, ofType: "epub") { arrList.append((aBook, path)) }}
  }
    
    
}