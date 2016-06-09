//
//  ManagerAudio.swift
//  testAlbom
//
//  Created by FE Team TV on 6/2/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import AVFoundation

class ManagerAudio: FileAlbumManager {
    
    var audioPlayer: AVAudioPlayer!
    var volume: Float = 0.0
    
    init() {
        super.init(nameDir: "audios")
        audioPlayer = AVAudioPlayer() }
    
    func getDurationbyUrl (nameUrl: NSURL) -> String {
        let asset = AVURLAsset( URL: nameUrl, options: nil)
        let duration = asset.duration
        let audioDurationSeconds = CMTimeGetSeconds(duration)
        return audioDurationSeconds.strigTime
       
    }
    
    func setPlayer(url: NSURL) {
       
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        self.audioPlayer.delegate = self
    }
    
    func play() {
        dispatch_async(dispatch_get_main_queue(), {
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
        })
        
    }
    
    func playRandom() {
        let row = randomNumber()
        NSNotificationCenter.defaultCenter().postNotificationName("PlayerCange", object: row, userInfo: nil)
        setPlayer(arrList[row]["path"] as! NSURL)
        play()
    }
    
    func timeLeft() -> String {
      return (audioPlayer.duration - audioPlayer.currentTime).strigTime
    }
    
    func stop() {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
    }
    
    func pause() {
        audioPlayer.pause()       
    }
    
    func setVolum(val: Float) {
         volume = val
         audioPlayer.volume = val
    }
    
    func setTime(val: Float) {
        if val == Float(audioPlayer.duration) {
            audioPlayer.stop()
        } else {
            audioPlayer.currentTime = Double(val) }
    }
    
    func getDurationString() -> String {
       return audioPlayer.duration.strigTime
    }
    
    func getDurationFloat() -> Float {
        return Float(audioPlayer.duration)
    }
    
    func randomNumber(range: Range<Int> = 0...3) -> Int {
        let min = range.startIndex
        let max = range.endIndex
        return Int(arc4random_uniform(UInt32(max - min)))
    }
    
}

extension NSTimeInterval {
    var strigTime: String { return String(format: "%02d:%02d", (Int(self/60)),(Int(self%60)))}
   
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
