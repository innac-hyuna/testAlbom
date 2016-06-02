//
//  Manager.swift
//  testAlbom
//
//  Created by FE Team TV on 6/2/16.
//  Copyright © 2016 courses. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit


class ManagerVideo {

    var url: NSURL = NSURL()
    var arr = ["Video.mp4", "Video1.m4v"]
    var arrList = [(String, NSURL)]()
    var playerController: AVPlayerViewController!
    var player: AVPlayer!
    
    func getDataArray() {
        for aBook in arr {
            let fileName = aBook.substringToIndex(aBook.indexOf("."))
            let fileFor = aBook.substringFromIndex(aBook.indexOf("."))
            if let path = NSBundle.mainBundle().URLForResource(fileName, withExtension: fileFor, subdirectory: nil, localization: nil) {
                arrList.append((aBook, path)) }}    
    }
    
    func setPlayer(urlVideo: NSURL) {
        player = AVPlayer(URL: urlVideo)
        playerController = AVPlayerViewController()
        playerController.player = player
    }
    func play() {
        player.play()
    }
    

}
