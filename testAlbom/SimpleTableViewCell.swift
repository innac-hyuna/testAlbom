//
//  SimpleTableViewCell.swift
//  testAlbom
//
//  Created by FE Team TV on 5/31/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {

    var titleLabel: UILabel!
    var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        contentView.backgroundColor = UIColor(patternImage: UIImage.bgMainImage())
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.textColor()
        titleLabel.font =  UIFont.HelTextFont(16)
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
        timeLabel = UILabel()
        timeLabel.textColor = UIColor.textColor()
        timeLabel.font =  UIFont.HelTextFont(16)
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
    
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout () {
        
        NSLayoutConstraint(item: titleLabel,
                           attribute: NSLayoutAttribute.CenterY,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.CenterY,
                           multiplier: 1.0,
                           constant: 0).active = true
        NSLayoutConstraint(item: titleLabel,
                           attribute: NSLayoutAttribute.Leading,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.Leading,
                           multiplier: 1.0,
                           constant: 20).active = true
        
        NSLayoutConstraint(item: timeLabel,
                           attribute: NSLayoutAttribute.CenterY,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.CenterY,
                           multiplier: 1.0,
                           constant: 0).active = true
        NSLayoutConstraint(item: timeLabel,
                           attribute: NSLayoutAttribute.Trailing,
                           relatedBy: NSLayoutRelation.Equal,
                           toItem: contentView,
                           attribute: NSLayoutAttribute.Trailing,
                           multiplier: 1.0,
                           constant: -10).active = true
    }

}
