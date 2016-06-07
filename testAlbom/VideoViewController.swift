//
//  VideoViewController.swift
//  testAlbom
//
//  Created by FE Team TV on 6/1/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    
    var urlVideo: NSURL!
    var compactConstraints: [NSLayoutConstraint] = []
    var topBar: UILayoutSupport!
    var videoData: ManagerVideo!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar = self.topLayoutGuide
        
        videoData = ManagerVideo()
        videoData.setPlayer(urlVideo)        
        self.addChildViewController(videoData.playerController)
        self.view.addSubview(videoData.playerController.view)
        videoData.playerController.view.frame = self.view.frame
        videoData.play()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 }
