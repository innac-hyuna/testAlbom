//
//  MusicViewController.swift
//  testAlbom
//
//  Created by FE Team TV on 5/31/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import FolioReaderKit
import M13PDFKit

class BookViewController: UIViewController {
    
    var tableView: UITableView!
    var topBar: UILayoutSupport!
    var compactConstraint: [NSLayoutConstraint] = []
    var bookData: ManagerBook!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookData = ManagerBook()
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

extension BookViewController: UITableViewDelegate {
    
    func  tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
}

extension BookViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SimpleTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SimpleTableViewCell
        cell.titleLabel.text = bookData.arrList[indexPath.row]["name"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
      if  bookData.arrList[indexPath.row]["type"] as! String == ".epub" {
        let config = FolioReaderConfig()
        if let path = (bookData.arrList[indexPath.row]["path"] as! NSURL).path {
            FolioReader.presentReader(parentViewController: self, withEpubPath: path , andConfig: config)}
      } else {
      
        let viewer: PDFKBasicPDFViewer = PDFKViewController()  as PDFKBasicPDFViewer
        let document: PDFKDocument = PDFKDocument(contentsOfFile: (bookData.arrList[indexPath.row]["path"] as! NSURL).path , password: nil)
        viewer.loadDocument(document)
        navigationController?.pushViewController(viewer, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookData.arrList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}
