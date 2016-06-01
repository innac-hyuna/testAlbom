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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let MusicItem = MusicViewController()
        MusicIcon = UITabBarItem(title: "", image: UIImage(named: "Musical0"), selectedImage: UIImage(named: "Musical1"))
        MusicItem.tabBarItem = MusicIcon
        
        let BookItem = BookViewController()
        BookIcon = UITabBarItem(title: "", image: UIImage(named: "Book0"), selectedImage: UIImage(named: "Book1"))
        BookItem.tabBarItem = BookIcon
        
        let FilmsItem = FilmsViewController()
        FilmsIcon = UITabBarItem(title: "", image: UIImage(named: "Film0"), selectedImage: UIImage(named: "Film1"))
        FilmsItem.tabBarItem = FilmsIcon
        
        let controllers = [MusicItem, BookItem, FilmsItem]
        self.viewControllers = controllers
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CategoryViewController: UITabBarControllerDelegate {

    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("press item \(viewController.title)")
    }
}

