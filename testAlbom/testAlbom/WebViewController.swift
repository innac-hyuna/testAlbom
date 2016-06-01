//
//  WebViewController.swift
//  testAlbom
//
//  Created by FE Team TV on 6/1/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
   
    var webBook: UIWebView!
    var urlBook: NSURL!
    var compactConstraints: [NSLayoutConstraint] = []
   // var regularConstraints: [NSLayoutConstraint]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webBook = UIWebView()
        view.addSubview(webBook)
        webBook.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
        let req = NSURLRequest(URL: urlBook)
        webBook.loadRequest(req)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        NSLayoutConstraint.activateConstraints(compactConstraints)
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
    }
}
