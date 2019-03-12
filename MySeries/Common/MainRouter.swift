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
    static func create(withMainRouter mainRouter: MainRouterProtocol) -> UIViewController
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
        let tabBar = UITabBarController.init()
        let homeView = HomeRouter.create(withMainRouter: self)
        let seriesView = SeriesRouter.create(withMainRouter: self)
        
        homeView.tabBarItem = UITabBarItem.init(title: "HOME", image: nil, tag: 0)
        seriesView.tabBarItem = UITabBarItem.init(title: "SERIES", image: nil, tag: 1)
        
        tabBar.viewControllers = [homeView, seriesView]
        
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
