//
//  SubscriptionCell.swift
//  Youtube
//
//  Created by Vui Chee on 8/1/18.
//  Copyright © 2018 Chase. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos(completion: @escaping ([Video]) -> ()) {
        ApiService.sharedInstance.fetchSubscriptionFeed(completion: completion)
    }
}
