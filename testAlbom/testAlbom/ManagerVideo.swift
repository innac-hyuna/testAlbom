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


class ManagerVideo: FileAlbumManager {

    var playerController: AVPlayerViewController!
    var player: AVPlayer!
    
    init() {
       super.init(nameDir: "videos")
 
    }
    
    func setVideoPlayer(urlVideo: NSURL) {
        player = AVPlayer(URL: urlVideo)
        playerController = AVPlayerViewController()
        playerController.player = player
    }
    func play() {
        player.play()
    }   

}
