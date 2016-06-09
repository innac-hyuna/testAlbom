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
  let fileManager = NSFileManager.defaultManager()
  let booksPath: NSURL!
  init() {
    
    let destPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
    booksPath = NSURL(fileURLWithPath: destPath).URLByAppendingPathComponent("books")
    var con = []
    // if doesn't exist dir "books" and files
    if  !fileManager.fileExistsAtPath(booksPath.path!) {
        do {
            try fileManager.createDirectoryAtPath(booksPath.path!, withIntermediateDirectories: false, attributes: nil)
            for aBook in arr {
                let fileName = aBook.substringToIndex(aBook.indexOf("."))
                let fileFor = aBook.substringFromIndex(aBook.indexOf("."))
                if let bundel = NSBundle.mainBundle().pathForResource(fileName, ofType: fileFor){
                    copyFiles( bundel, fileName: aBook)}}
            
        }
        catch { print(error) }
    }
    do{ con = try fileManager.contentsOfDirectoryAtPath(booksPath.path!)}
    catch{
    print(error)
        
   }
    
    for aBook in con as! [String] {
            let fileName = aBook.substringToIndex(aBook.indexOf("."))
            let fileFor = aBook.substringFromIndex(aBook.indexOf("."))
            let fullDestPath = booksPath.URLByAppendingPathComponent(aBook)
            let fullDestPathString = fullDestPath.path      
            var dic: [String: String] = [:]
            dic["name"] = fileName
            dic["path"] = fullDestPathString
            dic["type"] = fileFor
            arrList.append(dic) }
    }
    
    func copyFiles(bundlePath: String, fileName: String) {
        
        let fullDestPath = booksPath.URLByAppendingPathComponent(fileName)
        let fullDestPathString = fullDestPath.path
        
        if  !fileManager.fileExistsAtPath(fullDestPathString!) {
            do {
                try fileManager.copyItemAtPath(bundlePath, toPath: fullDestPathString!)
            }catch{
                print("\n")
                print(error)
                }
            }
       }
    
   }