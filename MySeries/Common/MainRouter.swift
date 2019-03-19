//
//  MainRouter.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol MainRouterProtocol {
    func show(viewController: UIViewController, sender: Any?)
    func present(viewController: UIViewController, animated: Bool, completion:(() -> Void)?)
    func push(navigationController: UINavigationController?, viewController: UIViewController, animated: Bool)
}

protocol RouterFactory {
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController
}

class MainRouter {
    let window: UIWindow
    
    var rootViewController: UIViewController {
        
        guard let rootViewController = window.rootViewController else {
            fatalError("There is no rootViewController installed on the window")
        }
        
        return rootViewController
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension MainRouter {
    
    func presentRootViewController() {
        
        let rootViewController = UINavigationController(rootViewController: customTabBar())
        window.rootViewController = rootViewController
    }
    
    private func customTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        let homeView = HomeRouter.create(withMainRouter: self, parameters: nil)
        let seriesView = SeriesRouter.create(withMainRouter: self, parameters: nil)
        let searchView = SearchSerieRouter.create(withMainRouter: self, parameters: nil)
        
        homeView.tabBarItem = UITabBarItem(title: "HOME", image: nil, tag: 0)
        homeView.tabBarItem.image = UIImage(named: "home")
        seriesView.tabBarItem = UITabBarItem(title: "SERIES", image: nil, tag: 1)
        seriesView.tabBarItem.image = UIImage(named: "seriesIcon")
        searchView.tabBarItem = UITabBarItem(title: "SEARCH", image: nil, tag: 0)
        searchView.tabBarItem.image = UIImage(named: "searchIcon")
        
        let controllers = [homeView, seriesView, searchView]
        tabBar.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        tabBar.navigationItem.title = "MySERIES"
        
        UITabBar.appearance().barTintColor = UIColor(red: 0/255, green: 153/255, blue: 153/255, alpha: 1)
        UITabBar.appearance().tintColor = UIColor.black
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        tabBar.tabBar.unselectedItemTintColor = UIColor.white
        
        return tabBar
    }
}

extension MainRouter: MainRouterProtocol {
    func show(viewController: UIViewController, sender: Any?) {
        rootViewController.show(viewController, sender: sender)
    }
    
    func present(viewController: UIViewController, animated: Bool, completion:(() -> Void)?) {
        rootViewController.present(viewController, animated: animated, completion: completion)
    }
    
    func push(navigationController: UINavigationController?, viewController: UIViewController, animated: Bool) {
        if navigationController == nil {
            rootViewController.navigationController!.pushViewController(viewController, animated: animated)
        } else {
            navigationController?.pushViewController(viewController, animated: animated)
        }
    }
}
