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
        let tabBar = UITabBarController()
        let homeView = HomeRouter.create(withMainRouter: self, parameters: nil)
        let seriesView = SeriesRouter.create(withMainRouter: self, parameters: nil)
        
        homeView.tabBarItem = UITabBarItem(title: "HOME", image: nil, tag: 0)
        homeView.tabBarItem.image = UIImage(named: "home")
        seriesView.tabBarItem = UITabBarItem(title: "SERIES", image: nil, tag: 1)
        seriesView.tabBarItem.image = UIImage(named: "seriesIcon")
        
        let controllers = [homeView, seriesView]
        tabBar.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        tabBar.navigationItem.title = "MySERIES"
        
        let rootViewController = UINavigationController(rootViewController: tabBar)
        window.rootViewController = rootViewController
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
