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
        super.viewWillAppear(true)
        presenter.checkNewEpisodes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: celID)
        tableView.rowHeight = 120
        tableView.tableFooterView = UIView() //Clear extra lines
        
        showSpinner()
    }
    
    func updatePending() {
        removeSpinner()
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getPendingEpisodes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: celID, for: indexPath) as! TableViewCell
        
        let serie = presenter.getPendingEpisodes()[indexPath.row]
        
        cell.lblTitle.text = serie.serie.name
        cell.imgPicture.imageFromUrl(urlString: serie.serie.image.medium)
        cell.set(episodes: serie.episodes)
        cell.delegate = self
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
}

extension HomeViewController: TableViewCellDelegate {
    func click(episode: Int) {
    }
}
