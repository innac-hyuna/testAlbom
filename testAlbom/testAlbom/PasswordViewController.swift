//
//  ViewController.swift
//  testAlbom
//
//  Created by FE Team TV on 5/30/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import KeychainSwift


class PasswordViewController: UIViewController {
    
    var mainView: UIView!
    var iconImg: UIImageView!
    var titleLabel: UILabel!
    var loginView: UIView!
    var loginImg: UIImageView!
    var loginText: UITextField!
    var passwordView: UIView!
    var passwordImg: UIImageView!
    var passwordText: UITextField!
    var loginButton: UIButton!
    var topBar: UILayoutSupport!
    var compactConstraint = [NSLayoutConstraint]()
    var keychain: KeychainSwift!

    override func viewDidLoad() {
        super.viewDidLoad()       
      
        keychain = KeychainSwift()
        
        topBar = self.topLayoutGuide
        
        mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        
        iconImg  = UIImageView()
        iconImg.image = UIImage.bgIconImage()
        iconImg.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(iconImg)
        
        titleLabel = UILabel()
        titleLabel.text = "Login"
        titleLabel.font = UIFont.HelTextFont(16)
        titleLabel.textColor = UIColor.textColor()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(titleLabel)
        
        loginView = UIView()
        loginView.setStyle()
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        
        loginImg = UIImageView()
        loginImg.image = UIImage.bgLoginImage()
        loginImg.translatesAutoresizingMaskIntoConstraints = false
        loginView.addSubview(loginImg)
        
        loginText = UITextField()
        loginText.textColor = UIColor.textColor()
        loginText.delegate = self
        loginText.translatesAutoresizingMaskIntoConstraints = false
        loginView.addSubview(loginText)
        
        passwordView = UIView()
        passwordView.setStyle()
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordView)
        
        passwordImg = UIImageView()
        passwordImg.image = UIImage.bgPassswordImage()
        passwordImg.translatesAutoresizingMaskIntoConstraints = false
        passwordView.addSubview(passwordImg)
        
        passwordText = UITextField()
        passwordText.secureTextEntry = true
        passwordText.delegate = self
        passwordText.textColor = UIColor.textColor()
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordView.addSubview(passwordText)
        
        loginButton = UIButton(type: .Custom) as UIButton
        loginButton.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        loginButton.setImage(UIImage.bgButtonLoginImage(), forState: .Normal)
        loginButton.addTarget(self, action: #selector(PasswordViewController.loginButtonAction(_:)), forControlEvents: .TouchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        setapLayout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonAction (sender: UIButton) {
        
        if loginText.text == "" || passwordText.text == ""
        { let alertView = UIAlertController(title: "Login Problem",
                                             message: "Wrong username or password." as String, preferredStyle:.Alert)
          let okAction = UIAlertAction(title: "Foiled Again!", style: .Default, handler: nil)
          alertView.addAction(okAction)
          self.presentViewController(alertView, animated: true, completion: nil)
          return
        }
        
        if NSUserDefaults.standardUserDefaults().valueForKey("loginkey") != nil  {
            //check login pasword
            if checkLoginPassword(loginText.text!, password: passwordText.text!)
            {   let CategoryController: CategoryViewController = CategoryViewController()
                navigationController?.pushViewController(CategoryController, animated: true)
            } else {
                let alertView = UIAlertController(title: "Login Problem",
                                                  message: "Wrong username or password." as String, preferredStyle:.Alert)
                let okAction = UIAlertAction(title: "Foiled Again!", style: .Default, handler: nil)
                alertView.addAction(okAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        } else {
            // Save login password
            if passwordText.text?.characters.count > 0 {
                if keychain.set(passwordText.text!, forKey: "passwordkey") {
                    NSUserDefaults.standardUserDefaults().setValue(loginText.text!, forKey: "loginkey")
                    print("save successful")
                }
            } else {
                print("not save ")}
        }
        
       loginText.text = ""
       passwordText.text = ""

    }
    
    func checkLoginPassword(login: String, password: String) -> Bool {
        
        if let passwordKey = keychain.get("passwordkey") {
            let loginKey = NSUserDefaults.standardUserDefaults().valueForKey("loginkey")
            if (password == passwordKey) && (login == loginKey as? String) {
                return true
            } else {
                return false }
        } else
        { return false }
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        NSLayoutConstraint.activateConstraints(compactConstraint)
        
    }
    
    func setapLayout() {
        
        //Compact Constaints
        
        compactConstraint.append(NSLayoutConstraint(
            item: mainView,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1.0,
            constant: 20))
        compactConstraint.append(NSLayoutConstraint(
            item: mainView,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0))
        compactConstraint.append(NSLayoutConstraint(
            item: mainView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 300 ))
        
        
        compactConstraint.append(NSLayoutConstraint(
            item: iconImg,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: mainView,
            attribute: NSLayoutAttribute.TopMargin,
            multiplier: 1.0,
            constant: 15))
        compactConstraint.append(NSLayoutConstraint(
            item: iconImg,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: mainView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0))
        
        compactConstraint.append(NSLayoutConstraint(
            item: titleLabel,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: iconImg,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 15))
        compactConstraint.append(NSLayoutConstraint(
            item: titleLabel,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: mainView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0))
        
        compactConstraint.append(NSLayoutConstraint(
            item: loginView,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: titleLabel,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 35))
        compactConstraint.append(NSLayoutConstraint(
            item: loginView,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: mainView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0))
        compactConstraint.append(NSLayoutConstraint(
            item: loginView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 40))
        compactConstraint.append(NSLayoutConstraint(
            item: loginView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 250))

        
        compactConstraint.append(NSLayoutConstraint(
            item: passwordView,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: loginView,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 25))
        compactConstraint.append(NSLayoutConstraint(
            item: passwordView,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: mainView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0))
        compactConstraint.append(NSLayoutConstraint(
            item: passwordView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 40))
        compactConstraint.append(NSLayoutConstraint(
            item: passwordView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 250))
        
        setapLayoutText(loginImg, dText: loginText, dView: loginView)
        setapLayoutText(passwordImg, dText: passwordText, dView: passwordView)
        
        compactConstraint.append(NSLayoutConstraint(
            item: loginButton,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: passwordView,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 25))
        compactConstraint.append(NSLayoutConstraint(
            item: loginButton,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: mainView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0))

    }
    
    func setapLayoutText(dImg: UIImageView, dText: UITextField, dView: UIView) {
       
        compactConstraint.append(NSLayoutConstraint(
            item: dImg,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: dView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 10))
        compactConstraint.append(NSLayoutConstraint(
            item: dImg,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: dView,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1.0,
            constant: 0))
        
        compactConstraint.append(NSLayoutConstraint(
            item: dText,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: dImg,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 10))
        compactConstraint.append(NSLayoutConstraint(
            item: dText,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 200))
        compactConstraint.append(NSLayoutConstraint(
            item: dText,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: dView,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1.0,
            constant: 0))
    }
}

extension PasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField != ""{
            return true} else
        {return false}
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
     self.view.endEditing(true)
      return true
    }

}

