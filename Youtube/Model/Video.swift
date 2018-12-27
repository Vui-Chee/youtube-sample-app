//
//  Video.swift
//  Youtube
//
//  Created by Vui Chee on 6/27/18.
//  Copyright © 2018 Chase. All rights reserved.
//

import UIKit

class SafeJsonObject : NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        // In my opinion, NOT USEFUL.
        //        let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        //        let range = key.startIndex...key.startIndex
        //        let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
        let selector = NSSelectorFromString(key)
        let responds = self.responds(to: selector)
        
        if (!responds) {
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
}

class Video : SafeJsonObject {
    @objc var thumbnail_image_name : String?
    @objc var title : String?
    @objc var number_of_views : NSNumber?
    @objc var uploadDate : NSDate?
    
    @objc var channel : Channel?
    
    @objc var duration : NSNumber?
    
    init(dictionary : [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "channel" {
            self.channel = Channel()
            channel?.setValuesForKeys(value as! [String : Any])
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

class Channel : NSObject {
    @objc var name : String?
    @objc var profile_image_name : String?
}
