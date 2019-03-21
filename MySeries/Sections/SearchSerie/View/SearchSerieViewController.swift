//
//  SearchSerieViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 19/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SearchSerieViewControllerProtocol: ParentViewControllerProtocol {
    func update(series: [SearchSerieModel])
}

class SearchSerieViewController: ParentViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let celID = "cellSearchSerie"
    var series = [SearchSerieModel]()
    
    //Search Bar
    var searchController: UISearchController?
    
    let presenter: SearchSeriePresenterProtocol
    
    init(presenter: SearchSeriePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "SearchSerieViewController", bundle: nil, presenterParent: presenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SearchSerieViewController: SearchSerieViewControllerProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SearchSerieTableViewCell", bundle: nil), forCellReuseIdentifier: celID)
        tableView.rowHeight = 90
        tableView.tableFooterView = UIView() //Clear extra lines
        
        configureSearchBar()
    }
    
    func update(series: [SearchSerieModel]) {
        self.series = series
        tableView.reloadData()
    }
    
    private func configureSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.delegate = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "BUSCAR"
        searchController?.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = false
        tableView.tableHeaderView = searchController?.searchBar
    }
}

extension SearchSerieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: celID, for: indexPath) as! SearchSerieTableViewCell
        
        let serie = series[indexPath.row]
        
        cell.set(serie: serie.show, score: serie.score)
        cell.delegate = self
        
        return cell
    }
}

extension SearchSerieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        presenter.searchSeries(text: searchText)
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        series.removeAll()
        tableView.reloadData()
    }
}

extension SearchSerieViewController: SearchFavoriteDelegate {
    func save(serie: Serie) {
        presenter.save(serie: serie)
    }
    
    func delete(serie: Int) {
        presenter.delete(serieID: serie)
    }
    
}
