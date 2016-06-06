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
    var timeSlider: UISlider!
    var timeLabel: UILabel!
    var audioTimer: NSTimer!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar = self.topLayoutGuide

        volumeSlider = UISlider()
        volumeSlider.enabled = false
        volumeSlider.value = 0.3
        volumeSlider.addTarget(self, action: #selector(MusicViewController.sliderMov(_:)), forControlEvents: UIControlEvents.ValueChanged)
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(volumeSlider)
     
        timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeLabel)
        
        timeSlider = UISlider()
        timeSlider.minimumValue = 0
        timeSlider.maximumTrackTintColor = UIColor.borderFildColor()
        timeSlider.setThumbImage(UIImage(named:"Stop-44"), forState: UIControlState.Normal)
        timeSlider.enabled = false
        timeSlider.addTarget(self, action: #selector(MusicViewController.timeMov(_:)), forControlEvents: UIControlEvents.ValueChanged)
        timeSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeSlider)
        
        buttonPlay = UIButton(type: .Custom) as UIButton
        buttonPlay.setImage(UIImage(named: "Play-44"), forState: .Normal)
        buttonPlay.frame = CGRectMake(0, 0, 44, 44)
        buttonPlay.addTarget(self, action: #selector(MusicViewController.playAction(_:)), forControlEvents: .TouchUpInside)
        buttonPlay.enabled = false
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonPlay)
    
        buttonPause = UIButton(type: .Custom) as UIButton
        buttonPause.setImage(UIImage(named: "Pause-44"), forState: .Normal)
        buttonPause.frame = CGRectMake(0, 0, 44, 44)
        buttonPause.addTarget(self, action: #selector(MusicViewController.pauseAction(_:)), forControlEvents: .TouchUpInside)
        buttonPause.enabled = false
        buttonPause.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonPause)
        
        butttonStop = UIButton(type: .Custom) as UIButton
        butttonStop.setImage(UIImage(named: "Stop-44"), forState: .Normal)
        butttonStop.frame = CGRectMake(0, 0, 44, 44)
        butttonStop.addTarget(self, action: #selector(MusicViewController.stopAction(_:)), forControlEvents: .TouchUpInside)
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
        
        audioData = ManagerAudio()
        audioData.volume = volumeSlider.value
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicViewController.setSelectRow(_:)), name:"PlayerCange", object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timeLeft() {
        timeLabel.text =  audioData.timeLeft()
        timeSlider.value = Float(audioData.audioPlayer.currentTime)
     }
 
    func sliderMov(sender: UISlider) {
        audioData.setVolum(volumeSlider.value)
    }
    
    func timeMov(sender: UISlider) {
        stop()
        audioData.setTime(timeSlider.value)
        print(timeSlider.value)
        play()
        
    }
    
    func setSelectRow(notif: NSNotification) {
        guard let row = notif.object as? Int else { return }
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle )
        setTimerSetings()
    }
    
    func setTimerSetings()  {
       timeSlider.value = 0
       timeLabel.text =  audioData.getDurationString()
       timeSlider.maximumValue = audioData.getDurationFloat()
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
            item: timeSlider,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: buttonPlay,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 25))
        compactConstraint.append(NSLayoutConstraint(
            item: timeSlider,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 25))
        
        compactConstraint.append(NSLayoutConstraint(
            item: timeLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: volumeSlider,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 45))
        compactConstraint.append(NSLayoutConstraint(
            item: timeLabel,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: timeSlider,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 5))
        compactConstraint.append(NSLayoutConstraint(
            item: timeLabel,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.TrailingMargin,
            multiplier: 1.0,
            constant: -5))

        
        compactConstraint.append(NSLayoutConstraint(
            item: tableView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: timeSlider,
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
    
    func playAction(sender: UIButton) {
      
        volumeSlider.enabled = true
        timeSlider.enabled = true
        butttonStop.enabled = true
        buttonPause.enabled = true
        buttonPlay.enabled = false
        play()
       
        }
    func play() {
        audioData.play()
        audioTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(MusicViewController.timeLeft), userInfo: nil, repeats: true)
        
    }
    
    func stopAction(sender: UIButton) {
        setTimerSetings()
        volumeSlider.enabled = false
        timeSlider.enabled = false
        butttonStop.enabled = false
        buttonPause.enabled = false
        buttonPlay.enabled = true
        stop()
    }
    
    func stop() {
        audioTimer.invalidate()
        audioData.stop()
    }
    
    func pauseAction(sender: UIButton) {
        volumeSlider.enabled = true
        timeSlider.enabled = true
        butttonStop.enabled = true
        buttonPause.enabled = false
        buttonPlay.enabled = true
        pause()
    }
    
    func pause() {
        audioTimer.invalidate()
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
        setTimerSetings()
        audioData.setVolum(volumeSlider.value)
        
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return audioData.arrList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

