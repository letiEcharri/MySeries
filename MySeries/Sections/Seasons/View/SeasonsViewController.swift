//
//  SeasonsViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SeasonsViewControllerProtocol {
    func update(seasons: [SeasonWithEpisodes])
    func getViewController() -> SeasonsViewController
    func updateView()
}

class SeasonsViewController: ParentViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(SeasonsCollectionViewCell.nib, forCellWithReuseIdentifier: SeasonsCollectionViewCell.cellID)
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 70)
            layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
            layout.minimumLineSpacing = 1.0
            layout.minimumInteritemSpacing = 1.0
            collectionView.setCollectionViewLayout(layout, animated: true)
            collectionView.reloadData()
        }
    }
    
    var serieID: Int?
    var seasons = [SeasonWithEpisodes]()
    var selectedIndexPath: IndexPath?

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
    
    func update(seasons: [SeasonWithEpisodes]) {
        self.seasons = seasons
        removeSpinner()
        collectionView.reloadData()
    }
    
    func getViewController() -> SeasonsViewController {
        return self
    }
    
    func updateView() {
        collectionView.reloadData()
    }
}

extension SeasonsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonsCollectionViewCell.cellID, for: indexPath) as? SeasonsCollectionViewCell
        
        if cell != nil {
            let currentSeason = seasons[indexPath.row]
            cell?.presenter = presenter
            cell?.serieID = serieID
            cell?.set(season: currentSeason)
            cell?.delegate = self
            
            return cell!
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        seasons[indexPath.row].isOpen = !seasons[indexPath.row].isOpen

        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var size = CGSize(width: UIScreen.main.bounds.width, height: 50)

        if selectedIndexPath == indexPath && seasons[indexPath.row].isOpen {
            size.height = CGFloat(((seasons[indexPath.row].season.episodeOrder ?? 0) * 25) + 60)
        }
        return size
    }
    
}

extension SeasonsViewController: SeasonsCollectionViewCellDelegate {
    func click(episode: Episode, seasonNumberEpisodes: Int) {
        presenter.goDetail(episode: episode, serieID: serieID ?? 0, seasonNumberEpisodes: seasonNumberEpisodes)
    }
    
    func watch(season: Int) {
        presenter.watch(season: season, serieID: serieID ?? 0)
    }
    
    func unwatched(season: Int) {
        presenter.unwatch(season: season, serieID: serieID ?? 0)
    }
}
