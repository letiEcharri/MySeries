//
//  SeriesViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 7/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SeriesViewControllerProtocol {
}

class SeriesViewController: ParentViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let celID = "seriesCell"
    var series = [CDSerie]()
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "Mis Series"
        
        tableView.register(UINib(nibName: "SerieListTableViewCell", bundle: nil), forCellReuseIdentifier: celID)
        tableView.tableFooterView = UIView() //Clear extra lines
        
        series = CoreDataManager().fetchSeries()
    }
}

extension SeriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: celID, for: indexPath) as! SerieListTableViewCell
        
        let serie = series[indexPath.row]
        cell.lblName.text = serie.name
        cell.idSerie = Int(serie.id)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.navigateToDetail(viewController: self)
    }
}
