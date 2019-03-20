//
//  SearchSerieTableViewCell.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 19/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

class SearchSerieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var imgFavorite: UIImageView!
    
    let favoriteIcon = UIImage(named: "favIconFull")
    let noFavoriteIcon = UIImage(named: "favIcon")
    
    var serie: Serie?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureView() {
    }
    
    @objc private func favoriteAction(_ sender: UITapGestureRecognizer) {
        var image = UIImage()
        
        if sender.view?.tag == 0 {
            sender.view?.tag = 1
            image = favoriteIcon ?? UIImage()
            if serie?.id != nil {
                CoreDataManager().save(serie: serie?.name ?? "", id: (serie?.id)!)
            }
        } else {
            sender.view?.tag = 0
            image = noFavoriteIcon ?? UIImage()
            if serie?.id != nil {
                CoreDataManager().deleteSerie(id: (serie?.id)!)
            }
        }
        
        if let favorite = sender.view as? UIImageView {
            favorite.image = image
        }
    }
    
    func set(serie: Serie, score: Double) {
        self.serie = serie
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(favoriteAction(_:)))
        imgFavorite.addGestureRecognizer(tap)
        
        imgPicture.imageFromUrl(urlString: serie.image?.medium ?? "")
        lblTitle.text = serie.name
        
        var genres = ""
        for item in serie.genres ?? [String]() {
            genres += "\(item) "
        }
        lblGenres.text = genres
        lblScore.text = score.format(f: ".2")
        
        if CoreDataManager().exitsSerie(id: serie.id) {
            imgFavorite.image = favoriteIcon
        } else {
            imgFavorite.image = noFavoriteIcon
        }
    }
    
}
