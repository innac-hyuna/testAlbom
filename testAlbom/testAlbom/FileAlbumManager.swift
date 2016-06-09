//
//  FileManager.swift
//  testAlbom
//
//  Created by FE Team TV on 6/8/16.
//  Copyright © 2016 courses. All rights reserved.
//

import Foundation

class FileAlbumManager: NSObject {
   
    let fileManager = NSFileManager.defaultManager()
    var albumsPath: NSURL!
    var arrList: [Dictionary<String, AnyObject>] = []
    var arr: [String] = []
    var nameDir: String = ""
   
    init(arr: [String], nameDir: String) {
        super.init()
        self.arr = arr
        self.nameDir = nameDir
        createAlbumDir()
    }
    
    func createAlbumDir() {
        let destPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        albumsPath = NSURL(fileURLWithPath: destPath).URLByAppendingPathComponent(nameDir)
        var con = []

        // for bug books copy all time
        if nameDir == "books" {
            if  fileManager.fileExistsAtPath(albumsPath.path!) {
                do { try fileManager.removeItemAtURL(albumsPath)}
                catch { print(error)}
            }}
        //*
        
        if  !fileManager.fileExistsAtPath(albumsPath.path!) {
            do {
                try fileManager.createDirectoryAtPath(albumsPath.path!, withIntermediateDirectories: false, attributes: nil)
                for aAlbum in arr {
                    let fileName = aAlbum.substringToIndex(aAlbum.indexOf("."))
                    let fileFor = aAlbum.substringFromIndex(aAlbum.indexOf("."))
                    if let bundel = NSBundle.mainBundle().pathForResource(fileName, ofType: fileFor){
                        copyFiles( bundel, fileName: aAlbum)}}
                
            }
            catch { print(error) }
        }
        
        do{ con = try fileManager.contentsOfDirectoryAtPath(albumsPath.path!)}
        catch{
          print(error)
        }
        
        for aAlbum: String in con as! [String] {
            let fileName = aAlbum.substringToIndex(aAlbum.indexOf("."))
            let fileFor = aAlbum.substringFromIndex(aAlbum.indexOf("."))
            let fullDestPath = albumsPath.URLByAppendingPathComponent(aAlbum)
            var dic: [String: AnyObject] = [:]
            dic["name"] = fileName
            dic["path"] = fullDestPath
            dic["type"] = fileFor
            arrList.append(dic) }
    }
    
    func copyFiles(bundlePath: String, fileName: String) {
        
        let fullDestPath = albumsPath.URLByAppendingPathComponent(fileName)
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
