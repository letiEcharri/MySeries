//
//  HomeViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 7/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol HomeViewControllerProtocol: ParentViewControllerProtocol {
    func updatePending()
    func getViewController() -> HomeViewController
}

class HomeViewController: ParentViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let celID = "homeCell"
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hideBackButton()
        showSpinner()
        presenter.checkNewEpisodes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: celID)
        tableView.rowHeight = 120
        tableView.tableFooterView = UIView() //Clear extra lines
    }
    
    func updatePending() {
        removeSpinner()
        if presenter.getPendingEpisodes().count > 0 {
            tableView.isHidden = false
            tableView.reloadData()
        } else {
            tableView.isHidden = true
        }
    }
    
    func getViewController() -> HomeViewController {
        return self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getPendingEpisodes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: celID, for: indexPath) as! TableViewCell
        
        let serie = presenter.getPendingEpisodes()[indexPath.row]
        
        cell.set(serie: serie.serie)
        cell.set(episodes: serie.episodes)
        cell.delegate = self
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goDetail(row: indexPath.row)
    }
}

extension HomeViewController: TableViewCellDelegate {
    func click(episode: Episode, serieID: Int) {
        presenter.show(episode: episode, serieID: serieID)
    }
}
