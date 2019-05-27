//
//  SeasonsCollectionViewCell.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SeasonsCollectionViewCellDelegate {
    func click(episode: Episode)
    func watch(season: Int)
    func unwatched(season: Int)
}

class SeasonsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lblSeason: UILabel!
    @IBOutlet weak var lblDates: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var episodesView: UIView!
    @IBOutlet weak var btnEye: UIButton!
    
    var isOpen = false
    var episodeRowHeight: CGFloat = 25
    
    var season: Season?
    var episodes = [Episode]()
    var seasonNumber = 0
    var serieID: Int?
    
    var delegate: SeasonsCollectionViewCellDelegate?
    
    var presenter: SeasonPresenterProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func set(info: Season) {
        imgPicture.imageFromUrl(urlString: info.image?.medium ?? "")
        lblSeason.text = "TEMPORADA \(info.number ?? 0) - \(String(info.episodeOrder ?? 0)) Caps"
        lblDates.text = "\(info.premiereDate?.formatDate() ?? "") - \(info.endDate?.formatDate() ?? "")"
        seasonNumber = info.number ?? 0
    }
    
    private func watched(_ value: Bool) {

        var image = UIImage()
        if value {
            image = Constants.Images.Episode.watched ?? UIImage()
        } else {
            image = Constants.Images.Episode.unwatched ?? UIImage()
        }
        
        btnEye.setBackgroundImage(image, for: .normal)
    }
    
    @objc func goToEpisodeDetailAction(_ sender: UITapGestureRecognizer) {
        for item in episodes where (item.id == sender.view?.tag) {
            delegate?.click(episode: item)
        }
    }

    @IBAction func watch(_ sender: UIButton) {
        sender.isEnabled = false
        
        presenter?.isWatched(season: season!, serieID: serieID ?? 0, completion: { (response) in
            sender.isEnabled = true
            
            if response {
                self.watched(false)
                self.watchFullSeason(false)
                self.delegate?.unwatched(season: self.seasonNumber)
            } else {
                self.watched(true)
                self.watchFullSeason(true)
                self.delegate?.watch(season: self.seasonNumber)
            }
        })
    }
    
    // MARK: Public functions
    
    func set(season: SeasonWithEpisodes) {
        self.season = season.season
        self.episodes = season.episodes
        set(info: season.season)
        watched(season.isWatched)

        var cont = 0
        for item in season.episodes {
            let epView = EpisodeView(frame: CGRect(x: 0, y: (CGFloat(cont) * episodeRowHeight) + 5, width: self.frame.width - 30, height: episodeRowHeight))
            let parameters = EpisodeView.Parameters(episodeID: item.id,
                                                    serieID: self.serieID ?? 0,
                                                    title: "\(item.number ?? 0) - \(item.name ?? "")",
                                                    isWatched: presenter?.isWatched(episode: item.id) ?? false)
            epView.set(parameters: parameters)
            epView.delegate = self
            episodesView.addSubview(epView)
            
            btnEye.tag = season.season.number ?? 0
            
            cont += 1
        }
    }
    
    func watchFullSeason(_ value: Bool) {
        for item in episodesView.subviews where (item is EpisodeView) {
            if let epView = item as? EpisodeView {
                epView.watch(value)
            }
        }
    }
}

extension SeasonsCollectionViewCell: EpisodeViewDelegate {
    func clickEye(episodeID: Int, watch: Bool) {
        
        presenter?.watch(episode: episodeID, value: watch)
        
        if self.season != nil {
            presenter?.isWatched(season: season!, serieID: serieID ?? 0, completion: { (response) in
                self.watched(response)
            })
        }
    }
    
    func clickView(_ parameters: EpisodeView.Parameters) {
        for item in episodes where (item.id == parameters.episodeID) {
            delegate?.click(episode: item)
        }
    }
}
