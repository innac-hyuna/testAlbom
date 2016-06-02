//
//  ManagerAudio.swift
//  testAlbom
//
//  Created by FE Team TV on 6/2/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import AVFoundation

class ManagerAudio {
    
    var audioPlayer = AVAudioPlayer()
    var url: NSURL = NSURL()
    var arr = ["Music1", "Music2"]
    var arrList = [(String, NSURL)]()
    
    func getDataArray() {
        for aBook in arr {
            if let path = NSBundle.mainBundle().URLForResource(aBook, withExtension: "mp3", subdirectory: nil, localization: nil) {
                arrList.append((aBook, path)) }}
    }
    
    func play() {
        dispatch_async(dispatch_get_main_queue(), {
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
            print("play")})
    }
    
    func stop() {
        audioPlayer.stop()
        print(audioPlayer.currentTime)
        audioPlayer.currentTime = 0
        print("stop")
    }
    
    func pause() {
        audioPlayer.pause()
        print("pause")
    }
    
    func setPlayer(controller: AVAudioPlayerDelegate, url: NSURL) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        audioPlayer.delegate = controller
    }

}
