//
//  WebViewController.swift
//  testAlbom
//
//  Created by FE Team TV on 6/1/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import FolioReaderKit
import M13PDFKit

class PDFKViewController: PDFKBasicPDFViewer {
   
       
    override func viewDidLoad() {
        super.viewDidLoad()
    navigationController?.navigationBar.tintColor = UIColor.bgTinReaderColor()
    for el in view.subviews {
            if el.isKindOfClass(UIToolbar){
                el.tintColor = UIColor.bgTinReaderColor()}
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 }
