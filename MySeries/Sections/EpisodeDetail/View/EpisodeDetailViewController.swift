//
//  EpisodeDetailViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol EpisodeDetailViewControllerProtocol {
}

class EpisodeDetailViewController: ParentViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    var episode: Episode?
    
    let presenter: EpisodeDetailPresenterProtocol
    
    init(presenter: EpisodeDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "EpisodeDetailViewController", bundle: nil, presenterParent: presenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension EpisodeDetailViewController: EpisodeDetailViewControllerProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = episode?.name ?? ""
    }
}
