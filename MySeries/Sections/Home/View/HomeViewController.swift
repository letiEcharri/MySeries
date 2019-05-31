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
    
    @IBOutlet weak var lblTitle: UILabel! {
        didSet {
            lblTitle.text = "home.pendingEps".localize.uppercased()
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.cellID)
            tableView.rowHeight = 120
            tableView.tableFooterView = UIView() //Clear extra lines
        }
    }
    @IBOutlet weak var lblNoEpisodes: UILabel! {
        didSet {
            lblNoEpisodes.text = "home.noPendingEps".localize
        }
    }
    
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
        presenter.cleanEpisodes()
        tableView.reloadData()
        presenter.checkNewEpisodes()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updatePending() {
        
        if presenter.getPendingEpisodes().count > 0 {
            tableView.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { 
                self.removeSpinner()
                self.tableView.reloadData()
            }
        } else {
            removeSpinner()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellID, for: indexPath) as! TableViewCell
        
        let serie = presenter.getPendingEpisodes()[indexPath.row]
        
        cell.set(serie: serie.serie)
        cell.set(episodes: serie.episodes)
        cell.delegate = self
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = presenter.getPendingEpisodes()[indexPath.row]
        presenter.goDetail(serie: selected)
    }
}

extension HomeViewController: TableViewCellDelegate {
    func click(episode: Episode, serieID: Int, seasonNumberEpisodes: Int) {
        presenter.show(episode: episode, serieID: serieID, seasonNumberEpisodes: seasonNumberEpisodes)
    }
}
