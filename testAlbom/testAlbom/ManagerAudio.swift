//
//  ManagerAudio.swift
//  testAlbom
//
//  Created by FE Team TV on 6/2/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import AVFoundation

class ManagerAudio: NSObject {
    
    var audioPlayer: AVAudioPlayer!
    var url: NSURL = NSURL()   
    var arr = ["Music1", "Music2"]
    var arrList = [(String, NSURL)]()
    
    override init() {
        
        audioPlayer = AVAudioPlayer()
       
        for aBook in arr {
            if let path = NSBundle.mainBundle().URLForResource(aBook, withExtension: "mp3", subdirectory: nil, localization: nil) {
                arrList.append((aBook, path)) }}
    }
    
    func setPlayer(url: NSURL) {

        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    func play() {
        dispatch_async(dispatch_get_main_queue(), {
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.delegate = self
            self.audioPlayer.play()
            print("play")})
    }
    
    func playRandom() {
        let row = randomNumber()
         NSNotificationCenter.defaultCenter().postNotificationName("PlayerCange", object: row, userInfo: nil)
        setPlayer(arrList[row].1)
        play()
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
    
    func randomNumber(range: Range<Int> = 0...1) -> Int {
        let min = range.startIndex
        let max = range.endIndex
        return Int(arc4random_uniform(UInt32(max - min)))
    }
    
}

extension ManagerAudio: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully
        flag: Bool) {
       playRandom()
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer,
                                        error: NSError?) {
    }
    
    func audioPlayerBeginInterruption(player: AVAudioPlayer) {
    }
    
    func audioPlayerEndInterruption(player: AVAudioPlayer) {
        
    }
}
