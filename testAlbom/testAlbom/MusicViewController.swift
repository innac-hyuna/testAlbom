//
//  MusicViewController.swift
//  testAlbom
//
//  Created by FE Team TV on 5/31/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {

    var tableView: UITableView!
    var topBar: UILayoutSupport!
    var audioData: ManagerAudio!
    var compactConstraint: [NSLayoutConstraint] = []
    var buttonPlay: UIButton!
    var buttonPause: UIButton!
    var butttonStop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar = self.topLayoutGuide
        
        audioData = ManagerAudio()
        audioData.getDataArray()
        
        buttonPlay = UIButton(type: .Custom) as UIButton
        buttonPlay.setImage(UIImage(named: "Play-44"), forState: .Normal)
        buttonPlay.frame = CGRectMake(0, 0, 44, 44)
        buttonPlay.addTarget(self, action: #selector(MusicViewController.play(_:)), forControlEvents: .TouchUpInside)
        buttonPlay.enabled = false
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonPlay)
    
        buttonPause = UIButton(type: .Custom) as UIButton
        buttonPause.setImage(UIImage(named: "Pause-44"), forState: .Normal)
        buttonPause.frame = CGRectMake(0, 0, 44, 44)
        buttonPause.addTarget(self, action: #selector(MusicViewController.pause(_:)), forControlEvents: .TouchUpInside)
        buttonPause.enabled = false
        buttonPause.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonPause)
        
        butttonStop = UIButton(type: .Custom) as UIButton
        butttonStop.setImage(UIImage(named: "Stop-44"), forState: .Normal)
        butttonStop.frame = CGRectMake(0, 0, 44, 44)
        butttonStop.addTarget(self, action: #selector(MusicViewController.stop(_:)), forControlEvents: .TouchUpInside)
        butttonStop.enabled = false
        butttonStop.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(butttonStop)
        
        tableView = UITableView()
        tableView.backgroundColor = UIColor(patternImage: UIImage.bgMainImage())
        tableView.registerClass(SimpleTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        setLayout()    
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setLayout() {
        
        compactConstraint.append(NSLayoutConstraint(
            item: buttonPlay,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: topBar,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 20))
        compactConstraint.append(NSLayoutConstraint(
            item: tableView,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0))
        
        compactConstraint.append(NSLayoutConstraint(
            item: buttonPause,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: topBar,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 20))
        compactConstraint.append(NSLayoutConstraint(
            item: buttonPause,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0))
        
        compactConstraint.append(NSLayoutConstraint(
            item: butttonStop,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: topBar,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 20))
        compactConstraint.append(NSLayoutConstraint(
            item: butttonStop,
            attribute: NSLayoutAttribute.TrailingMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.TrailingMargin,
            multiplier: 1.0,
            constant: 10))
        
        compactConstraint.append(NSLayoutConstraint(
            item: tableView,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: buttonPlay,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 15))
        compactConstraint.append(NSLayoutConstraint(
            item: tableView,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: butttonStop,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 15))
        compactConstraint.append(NSLayoutConstraint(
            item: tableView,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: buttonPause,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 15))
        compactConstraint.append(NSLayoutConstraint(
            item: tableView,
            attribute: NSLayoutAttribute.BottomMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 0))
        compactConstraint.append(NSLayoutConstraint(
            item: tableView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0))
        
         NSLayoutConstraint.activateConstraints(compactConstraint)
    }
    
    func play(sender: UIButton) {
        butttonStop.enabled = true
        buttonPause.enabled = true
        buttonPlay.enabled = false
        audioData.play()
        }
    
    func stop(sender: UIButton) {
        butttonStop.enabled = false
        buttonPause.enabled = false
        buttonPlay.enabled = true
        audioData.stop()
    }
    
    func pause(sender: UIButton) {
        butttonStop.enabled = true
        buttonPause.enabled = false
        buttonPlay.enabled = true
        audioData.pause()
    }   
 
}

extension MusicViewController: UITableViewDelegate {
    func  tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      return 44
    }
}

extension MusicViewController: UITableViewDataSource {
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SimpleTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SimpleTableViewCell
        cell.titleLabel.text = audioData.arrList[indexPath.row].0
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        buttonPlay.enabled = true
        audioData.setPlayer(self, url: audioData.arrList[indexPath.row].1)
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return audioData.arrList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

extension MusicViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully
        flag: Bool) {
        
        buttonPlay.enabled = true
        buttonPause.enabled = false
        butttonStop.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer,
                                        error: NSError?) {
    }
    
    func audioPlayerBeginInterruption(player: AVAudioPlayer) {
    }
    
    func audioPlayerEndInterruption(player: AVAudioPlayer) {        
       
    }
}
