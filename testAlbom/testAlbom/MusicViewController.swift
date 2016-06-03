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
    var volumeSlider: UISlider!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar = self.topLayoutGuide
        
        audioData = ManagerAudio()
        volumeSlider = UISlider()
        volumeSlider.enabled = false
        volumeSlider.addTarget(self, action: #selector(MusicViewController.slidermov(_:)), forControlEvents: UIControlEvents.ValueChanged)
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(volumeSlider)
               
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
        tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1))
        tableView.registerClass(SimpleTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        setLayout()
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicViewController.setSelectRow(_:)), name:"PlayerCange", object: nil)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slidermov(sender: UISlider) {
        if   audioData.audioPlayer != nil {
            audioData.audioPlayer.volume = volumeSlider.value
            print(audioData.audioPlayer.volume)}
      
    }
    
    func setSelectRow(notif: NSNotification) {//
        guard let row = notif.object as? Int else { return }
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle )
    }
    
    func setLayout() {
        
        compactConstraint.append(NSLayoutConstraint(
            item: buttonPlay,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: topBar,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 20))
        compactConstraint.append(NSLayoutConstraint(
            item: buttonPlay,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.LeadingMargin,
            multiplier: 1.0,
            constant: 0))
        
        compactConstraint.append(NSLayoutConstraint(
            item: buttonPause,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: topBar,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 20))
        compactConstraint.append(NSLayoutConstraint(
            item: buttonPause,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: buttonPlay,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 10))
        
        compactConstraint.append(NSLayoutConstraint(
            item: butttonStop,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: topBar,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 20))
        compactConstraint.append(NSLayoutConstraint(
            item: butttonStop,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: buttonPause,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 10))
        
        compactConstraint.append(NSLayoutConstraint(
            item: volumeSlider,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: topBar,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 25))
        compactConstraint.append(NSLayoutConstraint(
            item: volumeSlider,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: butttonStop,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 0))
        compactConstraint.append(NSLayoutConstraint(
            item: volumeSlider,
            attribute: NSLayoutAttribute.TrailingMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: -25))
        
        compactConstraint.append(NSLayoutConstraint(
            item: tableView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: buttonPlay,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 15))
        compactConstraint.append(NSLayoutConstraint(
            item: tableView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: butttonStop,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 15))
        compactConstraint.append(NSLayoutConstraint(
            item: tableView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: buttonPause,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 15))
        compactConstraint.append(NSLayoutConstraint(
            item: tableView,
            attribute: NSLayoutAttribute.Bottom,
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
        volumeSlider.enabled = true
        butttonStop.enabled = true
        buttonPause.enabled = true
        buttonPlay.enabled = false
        audioData.play()
        }
    
    func stop(sender: UIButton) {
        volumeSlider.enabled = false
        butttonStop.enabled = false
        buttonPause.enabled = false
        buttonPlay.enabled = true
        audioData.stop()
    }
    
    func pause(sender: UIButton) {
        volumeSlider.enabled = true
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
        audioData.setPlayer(audioData.arrList[indexPath.row].1)
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return audioData.arrList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

