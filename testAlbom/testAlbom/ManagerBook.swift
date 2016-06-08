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
  var arr = ["Book1.epub", "Book2.epub", "Book3.pdf", "Book2.pdf"]
    var arrList = [Dictionary<String, String>]()
    
  init() {
    for aBook in arr {
            let fileName = aBook.substringToIndex(aBook.indexOf("."))
            let fileFor = aBook.substringFromIndex(aBook.indexOf("."))
        if let bundel = NSBundle.mainBundle().pathForResource(fileName, ofType: fileFor){
            var dic: [String: String] = [:]
            dic["name"] = fileName
            dic["path"] = copyFiles( bundel, fileName: aBook)
            dic["type"] = fileFor
            arrList.append(dic) }         
      }
    }
    
    func copyFiles(bundlePath: String, fileName: String) -> String {
       
        let destPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        let fileManager = NSFileManager.defaultManager()
        let fullDestPath = NSURL(fileURLWithPath: destPath).URLByAppendingPathComponent(fileName)
        let fullDestPathString = fullDestPath.path
        
        do{
            try fileManager.copyItemAtPath(bundlePath, toPath: fullDestPathString!)
        }catch{
            print("\n")
            print(error)
        }
        return fullDestPathString!
    }
    
   }