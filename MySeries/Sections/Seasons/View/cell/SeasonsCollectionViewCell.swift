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
    
    var episodes = [Episode]()
    var seasonNumber = 0
    var serieID: Int?
    var isWatched = false
    
    var delegate: SeasonsCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func set(info: Season) {
        imgPicture.imageFromUrl(urlString: info.image?.medium ?? "")
        lblSeason.text = "TEMPORADA \(info.number ?? 0) - \(String(info.episodeOrder ?? 0)) Caps"
        lblDates.text = "\(info.premiereDate?.formatDate() ?? "") - \(info.endDate?.formatDate() ?? "")"
        seasonNumber = info.number ?? 0
    }
    
    private func watched(_ value: Bool) {
        isWatched = value
        
        var imageName = ""
        if value {
            imageName = "eyeIcon"
        } else {
            imageName = "noWatched"
        }
        
        if let image = UIImage(named: imageName) {
            btnEye.setBackgroundImage(image, for: .normal)
        }
    }
    
    @objc func goToEpisodeDetailAction(_ sender: UITapGestureRecognizer) {
        for item in episodes where (item.id == sender.view?.tag) {
            delegate?.click(episode: item)
        }
    }

    @IBAction func watch(_ sender: UIButton) {

        if !isWatched {
            watched(true)
            delegate?.watch(season: seasonNumber)
        } else {
            watched(false)
            delegate?.unwatched(season: seasonNumber)
        }
    }
    
    // MARK: Public functions
    
    func set(season: SeasonWithEpisodes) {
        self.episodes = season.episodes
        set(info: season.season)
        watched(season.isWatched)

        var cont = 0
        for item in season.episodes {
            let epView = EpisodeView(frame: CGRect(x: 0, y: (CGFloat(cont) * episodeRowHeight) + 5, width: self.frame.width - 30, height: episodeRowHeight))
            epView.set(title: "\(item.number ?? 0) - \(item.name ?? "")")
            epView.set(parameters: EpisodeView.Parameters(episodeID: item.id, serieID: self.serieID ?? 0))
            epView.delegate = self
            episodesView.addSubview(epView)
            
            btnEye.tag = season.season.number ?? 0
            
            cont += 1
        }
    }
}

extension SeasonsCollectionViewCell: EpisodeViewDelegate {
    
    func clickEye(_ parameters: EpisodeView.Parameters) {
        print("Click")
    }
    
    func clickView(_ parameters: EpisodeView.Parameters) {
        for item in episodes where (item.id == parameters.episodeID) {
            delegate?.click(episode: item)
        }
    }
}
