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
    var buttonPre: UIButton!
    var buttonNext: UIButton!
    var buttonRandom: UIButton!
    var volumeSlider: UISlider!
    var timeSlider: UISlider!
    var timeLabel: UILabel!
    var curentSec: NSIndexPath!
    var audioTimer: NSTimer!
    var volumeSliderImg: String!
    var timeSliderImg: String!
    var butListImg: String!
    var butRandImg: String!
    var buttonPreImg: String!
    var buttonNextImg: String!
    var buttonPlayImg: String!
    var buttonPauseImg: String!
    var cellInd: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
       
        volumeSliderImg = "Mu"
        timeSliderImg = "Mus"
        butListImg = "listplay"
        butRandImg = "random"
        buttonPreImg = "pre"
        buttonNextImg =  "next"
        buttonPlayImg = "Play-44"
        buttonPauseImg = "Pause-44" 
        cellInd = "Cell"
        
        topBar = self.topLayoutGuide
    
        volumeSlider = UISlider()
        volumeSlider.enabled = false
        volumeSlider.value = 0.3
        volumeSlider.tintColor = UIColor.bgFildColor()
        volumeSlider.setThumbImage(UIImage(named:volumeSliderImg), forState: UIControlState.Normal)
        volumeSlider.addTarget(self, action: #selector(MusicViewController.sliderMov(_:)), forControlEvents: UIControlEvents.ValueChanged)
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(volumeSlider)
     
        timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeLabel)
        
        timeSlider = UISlider()
        timeSlider.minimumValue = 0
        timeSlider.tintColor = UIColor.bgFildColor()
        timeSlider.setThumbImage(UIImage(named: timeSliderImg), forState: UIControlState.Normal)
        timeSlider.enabled = false
        timeSlider.addTarget(self, action: #selector(MusicViewController.timeMov(_:)), forControlEvents: UIControlEvents.ValueChanged)
        timeSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeSlider)
        
        buttonRandom = UIButton(type: .Custom) as UIButton
        if  NSUserDefaults.standardUserDefaults().boolForKey(defUsers.musicrandom)  {
            buttonRandom.setImage(UIImage(named: butRandImg), forState: .Normal)
        } else {
            buttonRandom.setImage(UIImage(named: butListImg), forState: .Normal)
        }
        buttonRandom.addTarget(self, action: #selector(MusicViewController.checkRandomAction(_:)), forControlEvents: .TouchUpInside)
        buttonRandom.frame = CGRectMake(0, 0, 44, 44)
        buttonRandom.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonRandom)
        
        buttonPre = UIButton(type: .Custom) as UIButton
        buttonPre.tag = 1
        buttonPre.enabled = false
        buttonPre.setImage(UIImage(named: buttonPreImg), forState: .Normal)
        buttonPre.frame = CGRectMake(0, 0, 44, 44)
        buttonPre.addTarget(self, action: #selector(MusicViewController.prewAction(_:)), forControlEvents: .TouchUpInside)
        buttonPre.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonPre)

        buttonNext = UIButton(type: .Custom) as UIButton
        buttonNext.tag = 2
        buttonNext.enabled = false
        buttonNext.setImage(UIImage(named: buttonNextImg), forState: .Normal)
        buttonNext.frame = CGRectMake(0, 0, 44, 44)
        buttonNext.addTarget(self, action: #selector(MusicViewController.nextAction(_:)), forControlEvents: .TouchUpInside)
        buttonNext.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonNext)
        
        buttonPlay = UIButton(type: .Custom) as UIButton
        buttonPlay.setImage(UIImage(named: buttonPlayImg), forState: .Normal)
        buttonPlay.frame = CGRectMake(0, 0, 44, 44)
        buttonPlay.addTarget(self, action: #selector(MusicViewController.playAction(_:)), forControlEvents: .TouchUpInside)
        buttonPlay.enabled = false
        buttonPlay.tag = 0
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonPlay)
        
        tableView = UITableView()
        tableView.backgroundColor = UIColor(patternImage: UIImage.bgMainImage())
        tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1))
        tableView.registerClass(SimpleTableViewCell.self, forCellReuseIdentifier: cellInd)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        setLayout()
        
        audioData = ManagerAudio()
        audioData.volume = volumeSlider.value
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicViewController.setSelectRow(_:)), name: notification.nConst, object: nil)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
       
        if buttonPlay.tag == 1 {
            pause()}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       func setLayout() {
        
        compactConstraint.append(NSLayoutConstraint(
            item: buttonPre,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: topBar,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 20))
        compactConstraint.append(NSLayoutConstraint(
            item: buttonPre,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.LeadingMargin,
            multiplier: 1.0,
            constant: 0))
        
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
            toItem: buttonPre,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 0))
        
        compactConstraint.append(NSLayoutConstraint(
            item: buttonNext,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: topBar,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 20))
        compactConstraint.append(NSLayoutConstraint(
            item: buttonNext,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: buttonPlay,
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
            constant: 23))
        compactConstraint.append(NSLayoutConstraint(
            item: volumeSlider,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: buttonNext,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 0))   
        
        compactConstraint.append(NSLayoutConstraint(
            item: buttonRandom,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: topBar,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 15))
        compactConstraint.append(NSLayoutConstraint(
            item: buttonRandom,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: volumeSlider,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 10))
        compactConstraint.append(NSLayoutConstraint(
            item: buttonRandom,
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
            constant: 15))
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
            constant: 25))
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
    
    func checkRandomAction(sender: UIButton) {
        if NSUserDefaults.standardUserDefaults().boolForKey(defUsers.musicrandom)  {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: defUsers.musicrandom)
            buttonRandom.setImage(UIImage(named: butListImg), forState: .Normal)
        } else {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: defUsers.musicrandom)
            buttonRandom.setImage(UIImage(named: butRandImg), forState: .Normal)
        }
    }
    
    func  prewAction (sender: UIButton) {
        audioData.playPrew()
    }
    
    func  nextAction (sender: UIButton) {
        audioData.playNext()
    }
    
    func playAction(sender: UIButton) {
        if audioData.audioPlayer.playing {
            pause()
        } else {
            play() }
    }
    
    func play() {
        setButton(1)
        audioData.play()
        audioTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(MusicViewController.timeLeft), userInfo: nil, repeats: true)
    }
    
    func timeLeft() {
        timeLabel.text =  audioData.timeLeft()
        timeSlider.value = Float(audioData.audioPlayer.currentTime)
    }
    
    func stop() {
        audioTimer.invalidate()
        audioData.stop()
    }
    
    func pause() {
        setButton(2)
        audioTimer.invalidate()
        audioData.pause()
    }
    
    
    func setPlayer(indexPath: NSIndexPath) {
        curentSec = indexPath
        audioData.setPlayer((audioData.arrList[indexPath.row]["path"] as! NSURL), indRow: indexPath.row)
        setTimerSetings()
        audioData.setVolum(volumeSlider.value)
        play()
    }
    
    func setButton(i: Int) {
        
        switch i {
        case 1: //play
            volumeSlider.enabled = true
            timeSlider.enabled = true
            buttonNext.enabled = true
            buttonPre.enabled = true
            buttonPlay.enabled = true
            buttonPlay.setImage(UIImage(named: buttonPauseImg), forState: .Normal)
            buttonPlay.tag = 1
        case 2: //pause
            volumeSlider.enabled = true
            timeSlider.enabled = true
            buttonPlay.setImage(UIImage(named: buttonPlayImg), forState: .Normal)
            buttonPlay.tag = 0
            
        default : break
            
        }
        
    }
}

extension MusicViewController: UITableViewDelegate {
    func  tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      return 44
    }
}

extension MusicViewController: UITableViewDataSource {
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SimpleTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellInd, forIndexPath: indexPath) as! SimpleTableViewCell
        cell.titleLabel.text = audioData.arrList[indexPath.row]["name"] as? String
        cell.timeLabel.text = audioData.getDurationbyUrl((audioData.arrList[indexPath.row]["path"] as! NSURL))
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         setPlayer(indexPath)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return audioData.arrList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

