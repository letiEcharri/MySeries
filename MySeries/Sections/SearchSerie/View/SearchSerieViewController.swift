//
//  SearchSerieViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 19/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SearchSerieViewControllerProtocol: ParentViewControllerProtocol {
}

class SearchSerieViewController: ParentViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
        
        // Do any additional setup after loading the view.
    }
}
