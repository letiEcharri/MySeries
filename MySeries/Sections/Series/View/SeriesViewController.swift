//
//  SeriesViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 7/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SeriesViewControllerProtocol {
    func getViewController() -> SeriesViewController
}

class SeriesViewController: ParentViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let celID = "seriesCell"
    var series = [CDSerie]()
    
    //Search Bar
    var searchController: UISearchController?
    var filteredSeries = [CDSerie]()
    var activeSearchBar = false
    
    let presenter: SeriesPresenterProtocol
    
    init(presenter: SeriesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "SeriesViewController", bundle: nil, presenterParent: presenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SeriesViewController: SeriesViewControllerProtocol {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hideBackButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SerieListTableViewCell", bundle: nil), forCellReuseIdentifier: celID)
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView() //Clear extra lines
        
        configureSearchBar()
        
        series = CoreDataManager().fetchSeries().sorted(by: { ($0.value(forKeyPath: "name") as! String).localizedCaseInsensitiveCompare(($1.value(forKeyPath: "name") as! String)) == ComparisonResult.orderedAscending } )
    }
    
    private func configureSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.delegate = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Nombre de la serie a buscar"
        tableView.tableHeaderView = searchController?.searchBar
    }
    
    func getViewController() -> SeriesViewController {
        return self
    }
}

extension SeriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !activeSearchBar ? series.count : filteredSeries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: celID, for: indexPath) as! SerieListTableViewCell
        
        var serie: CDSerie?
        
        if !activeSearchBar {
            serie = series[indexPath.row]
        } else {
            serie = filteredSeries[indexPath.row]
        }
        
        cell.lblName.text = serie!.name
        cell.idSerie = Int(serie!.id)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.navigateToDetail(serie: series[indexPath.row])
    }
}

extension SeriesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            filteredSeries = series.filter { ($0.name?.lowercased().contains(searchText.lowercased()))! }
            activeSearchBar = true
        } else {
            filteredSeries.removeAll(keepingCapacity: true)
            activeSearchBar = false
        }
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredSeries.removeAll(keepingCapacity: true)
        activeSearchBar = false
        tableView.reloadData()
    }
}
