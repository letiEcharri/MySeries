//
//  SerieDetailViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SerieDetailViewControllerProtocol {
}

class SerieDetailViewController: ParentViewController {
    
    var serie: Serie?
    
    init() {
        super.init(nibName: "SerieDetailViewController", bundle: nil, presenterParent: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SerieDetailViewController: SerieDetailViewControllerProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
