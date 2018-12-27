//
//  DefaultCell.swift
//  Youtube
//
//  Created by Vui Chee on 8/6/18.
//  Copyright © 2018 Chase. All rights reserved.
//

import UIKit

class DefaultCell: FeedCell {
    
    override func fetchVideos(completion: @escaping ([Video]) -> ()) {
        super.videos = [Video(dictionary: [String:AnyObject]() )]
    }
}
