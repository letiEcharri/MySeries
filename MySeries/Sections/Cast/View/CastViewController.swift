//
//  CastViewController.swift
//  MySeries
//
//  Created by Leticia Echarri on 28/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol CastViewControllerProtocol: ParentViewControllerProtocol {
}

class CastViewController: ParentViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.layer.borderWidth = 1
            collectionView.layer.borderColor = UIColor.white.cgColor
            collectionView.layer.cornerRadius = 10
        }
    }
    
    
    var cast = [Cast]()
    
    let presenter: CastPresenterProtocol
    
    init(presenter: CastPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "CastViewController", bundle: nil, presenterParent: presenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeAction(_ sender: UIButton) {
        presenter.close(view: self)
    }
}

extension CastViewController: CastViewControllerProtocol {
    
}
