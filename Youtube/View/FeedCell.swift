//
//  FeedCell.swift
//  Youtube
//
//  Created by Vui Chee on 8/1/18.
//  Copyright © 2018 Chase. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var videos : [Video]?
    let cellId = "cellId"
    
    // Used for hiding the nav bar on scroll direction.
    var navCon : UINavigationController?
    var lastOffsetY = CGFloat(0)
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastOffsetY = scrollView.contentOffset.y
    }
    
    func hideNavBarBasedOnScrollDirection(_ toHide: Bool) {
        if let navCon = navCon {
            navCon.setNavigationBarHidden(toHide, animated: true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        hideNavBarBasedOnScrollDirection(lastOffsetY < scrollView.contentOffset.y)
    }

    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        ApiService.sharedInstance.fetchVideos(completion: completion)
    }
    
    override func setupViews() {
        backgroundColor = UIColor.brown

        fetchVideos() { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9/16
        return CGSize.init(width: frame.width, height: height + 16 + 88)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
}
