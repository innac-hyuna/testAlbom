//
//  MusicViewController.swift
//  testAlbom
//
//  Created by FE Team TV on 5/31/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    var tableView: UITableView!
    var topBar: UILayoutSupport!
    var arrList = ["Book", "Book", "Book"]
    var compactConstraint: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBar = self.topLayoutGuide
        tableView = UITableView()
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
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        NSLayoutConstraint.activateConstraints(compactConstraint)
        
    }
    
    func setLayout() {
        
        compactConstraint.append(NSLayoutConstraint(
            item: tableView,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: topBar,
            attribute: NSLayoutAttribute.BottomMargin,
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
    }
    
}

extension BookViewController: UITableViewDelegate {
    func  tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
}

extension BookViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SimpleTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SimpleTableViewCell
        cell.textLabel?.text = arrList[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("select row")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}
