//
//  WebViewController.swift
//  testAlbom
//
//  Created by FE Team TV on 6/1/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import FolioReaderKit

class WebViewController: UIViewController {
   
    var webBook: UIWebView!
    var urlBook: String!
    var compactConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webBook = UIWebView()
        view.addSubview(webBook)
        webBook.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
        let config = FolioReaderConfig()
        FolioReader.presentReader(parentViewController: self, withEpubPath: urlBook, andConfig: config)
       //  webBook.loadRequest(req)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLayout() {
        compactConstraints.append(NSLayoutConstraint(item: webBook,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0))
        compactConstraints.append(NSLayoutConstraint(item: webBook,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0))
        compactConstraints.append(NSLayoutConstraint(item: webBook,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0))
        NSLayoutConstraint.activateConstraints(compactConstraints)

    }
}
