//
//  SeasonsViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SeasonsViewControllerProtocol {
    func update(seasons: [Season])
}

class SeasonsViewController: ParentViewController {
    
    var serieID: Int?

    let presenter: SeasonPresenterProtocol
    
    init(presenter: SeasonPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "SeasonsViewController", bundle: nil, presenterParent: presenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SeasonsViewController: SeasonsViewControllerProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSpinner()
        presenter.getSeasons(serieID: serieID ?? 0)
    }
    
    func update(seasons: [Season]) {
        removeSpinner()
    }
}
