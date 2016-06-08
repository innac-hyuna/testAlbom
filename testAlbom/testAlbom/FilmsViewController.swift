//
//  FilmsViewController.swift
//  testAlbom
//
//  Created by FE Team TV on 5/31/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit

class FilmsViewController: UIViewController {
    
    var tableView: UITableView!
    var topBar: UILayoutSupport!
    var videoData: ManagerVideo!
    var compactConstraint: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoData = ManagerVideo()
              
        topBar = self.topLayoutGuide
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
            item: tableView,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.TopMargin,
            multiplier: 1.0,
            constant: 0))
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
    
}

extension FilmsViewController: UITableViewDelegate {
    func  tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
}
extension FilmsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SimpleTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SimpleTableViewCell
        cell.titleLabel.text = videoData.arrList[indexPath.row].0
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let VideoController: VideoViewController = VideoViewController()
        VideoController.urlVideo = videoData.arrList[indexPath.row].1
        navigationController?.pushViewController(VideoController, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoData.arrList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

extension String {
    func indexOf(string: String) -> String.Index {
        return rangeOfString(string, options: .LiteralSearch, range: nil, locale: nil)?.startIndex ?? startIndex
    }
}
