//
//  Extensions.swift
//  Youtube
//
//  Created by Vui Chee on 6/25/18.
//  Copyright © 2018 Chase. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) ->UIColor {
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                      options: NSLayoutConstraint.FormatOptions(),
                                                      metrics: nil, views: viewsDictionary))
    }
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView : UIImageView {
    
    var imageUrlString : String?
    
    func loadImageUsingUrlString(urlString: String) {
        let url = NSURL(string: urlString)
        
        image = nil
        
        imageUrlString = urlString
        
        if let imageToCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageToCache
            return
        }
        
        URLSession.shared.dataTask(with: url! as URL) { (data, response, err) in
            if err != nil {
                print(err!)
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            }
            
        }.resume()
    }
}
