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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var serieID: Int?
    var seasons = [Season]()
    let cellID = "seasonCell"
    var size: CGFloat?
    var cellSize: CGSize?

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setCellSize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "SeasonsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        
        showSpinner()
        presenter.getSeasons(serieID: serieID ?? 0)
    }
    
    func update(seasons: [Season]) {
        self.seasons = seasons
        removeSpinner()
        collectionView.reloadData()
    }
    
    private func setCellSize() {
        cellSize = CGSize(width: UIScreen.main.bounds.width, height: 70)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize!
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
    }
}

extension SeasonsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? SeasonsCollectionViewCell
        
        if cell != nil {
            let season = seasons[indexPath.row]
            
            cell?.imgPicture.imageFromUrl(urlString: season.image?.medium ?? "")
            cell?.lblSeason.text = "TEMPORADA \(season.number ?? 0)"
            cell?.lblDates.text = "\(season.premiereDate?.formatDate() ?? "") - \(season.endDate?.formatDate() ?? "")"
            cell?.lblEpisodes.text = String(season.episodeOrder ?? 0)
            
            return cell!
        } else {
            return UICollectionViewCell()
        }
    }
}
