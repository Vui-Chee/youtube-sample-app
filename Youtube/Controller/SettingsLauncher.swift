//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Vui Chee on 6/30/18.
//  Copyright © 2018 Chase. All rights reserved.
//

import UIKit

class Setting : NSObject {
    let name : SettingName
    let imageName : String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName : String {
    case Settings = "Settings"
    case TermsPrivacy = "Terms & Privacy Policy"
    case SendFeedBack = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
    case Cancel = "Cancel"
}

class SettingsLauncher : NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let blackView = UIView()
    
    let cellId = "cellId"
    let cellHeight = 50
    
    var homeController : HomeController?
    
    let settings : [Setting] = {
        return [
            Setting(name: .Settings, imageName: "settings"),
            Setting(name: .TermsPrivacy, imageName: "privacy"),
            Setting(name: .SendFeedBack, imageName: "feedback"),
            Setting(name: .Help, imageName: "help"),
            Setting(name: .SwitchAccount, imageName: "switch_account"),
            Setting(name: .Cancel, imageName: "cancel")
        ]
    }()
    
    @objc func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let settingsMenuHeight = CGFloat(settings.count * cellHeight)
            let y = window.frame.height - settingsMenuHeight
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: settingsMenuHeight)
            
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: settingsMenuHeight)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss(_ setting: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: CGFloat(self.settings.count * self.cellHeight))
            }
            
        }, completion: { (hasCompleted) in
            
            if let setting = setting as? Setting, setting.name != .Cancel {
                self.homeController?.showControllerForSetting(setting)
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: CGFloat(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(setting)
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}
