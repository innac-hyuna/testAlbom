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
    var arr = ["Book", "Book1", "Book2", "Book3", "Book4", "Book5", "Book6"]
    var arrList = [(String, NSURL)]()
    var compactConstraint: [NSLayoutConstraint] = []
    var docController: UIDocumentInteractionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for aBook in arr {
        if let path = NSBundle.mainBundle().URLForResource(aBook, withExtension: "pdf", subdirectory: nil, localization: nil) { arrList.append((aBook, path)) }}

        tableView = UITableView()
        tableView.registerClass(SimpleTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(patternImage: UIImage.bgMainImage())
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
        cell.titleLabel.text = arrList[indexPath.row].0
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

       let WebController: WebViewController = WebViewController()
       WebController.urlBook = arrList[indexPath.row].1
       navigationController?.pushViewController(WebController, animated: true)

       /*let interactionController = UIDocumentInteractionController(URL:arrList[indexPath.row].1)
       interactionController.presentOptionsMenuFromRect(CGRectZero,
                                                         inView:self.view, animated:false)*/
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}
