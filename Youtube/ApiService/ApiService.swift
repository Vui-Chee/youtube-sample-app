//
//  ApiService.swift
//  Youtube
//
//  Created by Vui Chee on 7/28/18.
//  Copyright © 2018 Chase. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedFromUrlString("\(baseUrl)/home_num_likes.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedFromUrlString("\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedFromUrlString("\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedFromUrlString(_ urlString: String , completion: @escaping ([Video]) -> ()) {
        let url = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: url! as URL) { (data, response, err) in
            if err != nil {
                print(err ?? "error?")
                return
            }
            
            do {
                if let data = data, let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:AnyObject]] {
                    
                    DispatchQueue.main.async {
                        completion(json.map({ return Video(dictionary: $0) }))
                    }
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
}


//let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//
//var videos = [Video]()
//
//for dictionary in json as! [[String:Any]] {
//    let video = Video()
//    video.title = dictionary["title"] as? String
//    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//
//    let channelDictionary = dictionary["channel"] as? [String: AnyObject]
//    let channel = Channel()
//    channel.name = channelDictionary!["name"] as? String
//    channel.profileImageName = channelDictionary!["profile_image_name"] as? String
//    video.channel = channel
//
//    videos.append(video)
//}
//
//DispatchQueue.main.async {
//    completion(videos)
//}
