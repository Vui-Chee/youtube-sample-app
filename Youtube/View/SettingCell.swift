//
//  SettingCell.swift
//  Youtube
//
//  Created by Vui Chee on 7/2/18.
//  Copyright © 2018 Chase. All rights reserved.
//

import UIKit

class SettingCell : BaseCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting : Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLabel : UILabel = {
        let sl = UILabel()
        sl.text = "setting"
        sl.font = UIFont.systemFont(ofSize: 13)
        return sl
    }()
    
    let iconImageView : UIImageView = {
        let iiv = UIImageView()
        iiv.image = UIImage(named: "settings")
        iiv.contentMode = .scaleAspectFill
        return iiv
    }()
    
    override func setupViews() {
        super.setupViews()

        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)

        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
