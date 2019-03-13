//
//  HomeViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 7/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol HomeViewControllerProtocol: ParentViewControllerProtocol {
    func updatePending(episodes: [SerieEpisodes])
}

class HomeViewController: ParentViewController {
    
    let presenter: HomePresenterProtocol
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "HomeViewController", bundle: nil, presenterParent: presenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HomeViewController: HomeViewControllerProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.checkNewEpisodes()
    }
    
    func updatePending(episodes: [SerieEpisodes]) {
        print()
    }
}
