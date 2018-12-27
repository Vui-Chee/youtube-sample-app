//
//  ViewController.swift
//  Youtube
//
//  Created by Vui Chee on 6/24/18.
//  Copyright © 2018 Chase. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    let defaultCellId = "defaultCellId"
    
    override var prefersStatusBarHidden: Bool {
        return CustomUINavigationController.hidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel

        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        collectionView?.register(DefaultCell.self, forCellWithReuseIdentifier: defaultCellId)
        
        collectionView?.contentInset = UIEdgeInsets.init(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets.init(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    private func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }

    lazy var settingsLauncher : SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()

    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func showControllerForSetting(_ setting: Setting){
        let dummyControllerForSettings = UIViewController()
        dummyControllerForSettings.view.backgroundColor = UIColor.white
        dummyControllerForSettings.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummyControllerForSettings, animated: true)
    }
    
    @objc func handleSearch() {
//        print("searching")
//        scrollToMenuIndex(2)
    }
    
    func scrollToMenuIndex(_ menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
        
        setTitleForIndex(menuIndex)
    }
    
    private func setTitleForIndex(_ index : Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarViewConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = Int(targetContentOffset.move().x / view.frame.width)
        let indexPath = NSIndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: false, scrollPosition: .centeredHorizontally)
        
        setTitleForIndex(index)
    }
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true

        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var cell : UICollectionViewCell?
        let cellIds = [cellId, trendingCellId, subscriptionCellId, defaultCellId]
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIds[indexPath.item], for: indexPath)
      
        
        // Used to hide nav bar during scrolling.
        if let cell = cell as? FeedCell, cell.navCon == nil {
            print("set navcon")
            cell.navCon = navigationController
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
} // End class
