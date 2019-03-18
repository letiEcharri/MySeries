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
}

class SeasonsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lblSeason: UILabel!
    @IBOutlet weak var lblDates: UILabel!
    @IBOutlet weak var lblEpisodes: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var episodesView: UIView!
    
    var isOpen = false
    var episodeRowHeight: CGFloat = 25
    
    var episodes = [Episode]()
    
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
        lblSeason.text = "TEMPORADA \(info.number ?? 0)"
        lblDates.text = "\(info.premiereDate?.formatDate() ?? "") - \(info.endDate?.formatDate() ?? "")"
        lblEpisodes.text = String(info.episodeOrder ?? 0)
    }
    
    func set(season: SeasonWithEpisodes) {
        self.episodes = season.episodes
        set(info: season.season)
        
        var cont = 0
        for item in season.episodes {
            let label = UILabel(frame: CGRect(x: 0, y: (CGFloat(cont) * episodeRowHeight) + 5, width: episodesView.frame.width, height: episodeRowHeight))
            label.font = UIFont(name: "Noteworthy-Light", size: 15)
            label.text = "\(item.number ?? 0) - \(item.name ?? "")"
            label.tag = item.id
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(goToEpisodeDetailAction(_:)))
            label.addGestureRecognizer(tap)
            
            episodesView.addSubview(label)
            cont += 1
        }
    }
    
    @objc func goToEpisodeDetailAction(_ sender: UITapGestureRecognizer) {
        for item in episodes where (item.id == sender.view?.tag) {
            delegate?.click(episode: item)
        }
    }

}
