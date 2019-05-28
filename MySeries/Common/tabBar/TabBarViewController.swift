//
//  TabBarViewController.swift
//  MySeries
//
//  Created by Leticia Echarri on 28/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let mainRouter: MainRouter
    
    init(mainRouter: MainRouter) {
        self.mainRouter = mainRouter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let homeView = HomeRouter.create(withMainRouter: mainRouter, parameters: nil)
        let seriesView = SeriesRouter.create(withMainRouter: mainRouter, parameters: nil)
        let searchView = SearchSerieRouter.create(withMainRouter: mainRouter, parameters: nil)
        
        homeView.tabBarItem = UITabBarItem(title: "HOME", image: nil, tag: 0)
        homeView.tabBarItem.image = UIImage(named: "home")
        seriesView.tabBarItem = UITabBarItem(title: "SERIES", image: nil, tag: 1)
        seriesView.tabBarItem.image = UIImage(named: "seriesIcon")
        searchView.tabBarItem = UITabBarItem(title: "SEARCH", image: nil, tag: 0)
        searchView.tabBarItem.image = UIImage(named: "searchIcon")
        
        let controllers = [homeView, seriesView, searchView]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        self.navigationItem.title = "MySERIES"
        self.tabBar.isTranslucent = true
        
        UITabBar.appearance().barTintColor = UIColor.appColor
        UITabBar.appearance().tintColor = UIColor.black
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        self.tabBar.unselectedItemTintColor = UIColor.white
    }

}
