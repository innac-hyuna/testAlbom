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
    var nameDir: String = ""
   
    init(nameDir: String) {
        super.init()
        self.nameDir = nameDir
        createAlbumDir()
    }
    
    func createAlbumDir() {
        let destPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        albumsPath = NSURL(fileURLWithPath: destPath).URLByAppendingPathComponent(nameDir)
      
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
                   let bundel = "\(NSBundle.mainBundle().bundlePath)/\(nameDir)"
                        for aAlbum in getListofResource(bundel){
                           copyFiles("\(bundel)/\(aAlbum)", fileName: aAlbum) }
                           
            }
            catch { print(error) }
        }
        
        for aAlbum: String in getListofResource(albumsPath.path!) {
            let fileName = aAlbum.substringToIndex(aAlbum.indexOf("."))
            let fileFor = aAlbum.substringFromIndex(aAlbum.indexOf("."))
            let fullDestPath = albumsPath.URLByAppendingPathComponent(aAlbum) 
            var dic: [String: AnyObject] = [:]
            dic["name"] = fileName
            dic["path"] = fullDestPath
            dic["type"] = fileFor
            arrList.append(dic) }
    }
    
    func getListofResource(bundURl: String) -> [String] {
        var con = []
        do{ con = try fileManager.contentsOfDirectoryAtPath(bundURl)}
        catch{
            print(error)
        }
        return con as! [String]
    }
    
    func copyFiles(bundlePath: String, fileName: String) {
        
        let fullDestPath = albumsPath.URLByAppendingPathComponent(fileName)
        if let fullDestPathString = fullDestPath.path {
        
        if  !fileManager.fileExistsAtPath(fullDestPathString) {
            do {
                try fileManager.copyItemAtPath(bundlePath, toPath: fullDestPathString)
            }catch{
                print("\n")
                print(error)
            }
            }}
    }

    
}
