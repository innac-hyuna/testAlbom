//
//  VideoViewController.swift
//  testAlbom
//
//  Created by FE Team TV on 6/1/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController {
    
    var urlVideo: NSURL!
    var compactConstraints: [NSLayoutConstraint] = []
    var playerController: AVPlayerViewController!
    var topBar: UILayoutSupport!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar = self.topLayoutGuide
        
        let player = AVPlayer(URL: urlVideo)
        playerController = AVPlayerViewController()
        playerController.player = player
        self.addChildViewController(playerController)
        self.view.addSubview(playerController.view)        
        playerController.view.frame = self.view.frame
        player.play()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupLayout() {
        compactConstraints.append(NSLayoutConstraint(item: playerController.view,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: topBar,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 15))
        compactConstraints.append(NSLayoutConstraint(item: playerController.view,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0))
        compactConstraints.append(NSLayoutConstraint(item: playerController.view,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0))
        
      NSLayoutConstraint.activateConstraints(compactConstraints)
    }
}