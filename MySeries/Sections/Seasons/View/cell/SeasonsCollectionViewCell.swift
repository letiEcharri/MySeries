//
//  SeasonsCollectionViewCell.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

class SeasonsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lblSeason: UILabel!
    @IBOutlet weak var lblDates: UILabel!
    @IBOutlet weak var lblEpisodes: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var episodesView: UIView!
    
    var isOpen = false
    
    var episodes = [Episode]()
    
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
            let label = UILabel(frame: CGRect(x: 0, y: CGFloat(cont * 20) + 5, width: episodesView.frame.width, height: 20))
            label.font = UIFont(name: "Noteworthy-Light", size: 15)
            label.text = "\(item.number ?? 0) - \(item.name ?? "")"
            
            episodesView.addSubview(label)
            cont += 1
        }
    }

}
