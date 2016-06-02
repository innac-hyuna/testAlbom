//
//  CategoryViewController.swift
//  testAlbom
//
//  Created by FE Team TV on 5/31/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit

class CategoryViewController: UITabBarController {
    
    var MusicIcon: UITabBarItem!
    var BookIcon: UITabBarItem!
    var FilmsIcon: UITabBarItem!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        title = "Category"
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.tabBar.tintColor = UIColor.tabBarColor()
        
        let MusicItem = MusicViewController()
        MusicIcon = UITabBarItem(title: "Musics", image: UIImage(named: "Musical0"), selectedImage: UIImage(named: "Musical1"))
        MusicItem.tabBarItem = MusicIcon
        
        let BookItem = BookViewController()
        BookIcon = UITabBarItem(title: "Books", image: UIImage(named: "Book0"), selectedImage: UIImage(named: "Book1"))
        BookItem.tabBarItem = BookIcon
        
        let FilmsItem = FilmsViewController()
        FilmsIcon = UITabBarItem(title: "Films", image: UIImage(named: "Film0"), selectedImage: UIImage(named: "Film1"))
        FilmsItem.tabBarItem = FilmsIcon
        
        let controllers = [MusicItem, BookItem, FilmsItem]
        self.viewControllers = controllers
    
    }

}

extension CategoryViewController: UITabBarControllerDelegate {

    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {

    }
}

