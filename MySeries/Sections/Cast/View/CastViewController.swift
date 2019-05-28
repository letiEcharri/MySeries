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
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(CastCollectionViewCell.nib, forCellWithReuseIdentifier: CastCollectionViewCell.cellID)
            
            collectionView.layer.borderWidth = 1
            collectionView.layer.borderColor = UIColor.white.cgColor
            collectionView.layer.cornerRadius = 10
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: 110, height: 173)
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 0
            collectionView.setCollectionViewLayout(layout, animated: true)
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

extension CastViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.cellID, for: indexPath) as? CastCollectionViewCell
        
        if cell != nil {
            
            let currentCast = cast[indexPath.row]
            cell?.set(cast: currentCast)
            
            return cell!
        }
        
        return UICollectionViewCell()
    }
}
