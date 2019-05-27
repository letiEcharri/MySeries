//
//  SearchSerieTableViewCell.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 19/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SearchFavoriteDelegate {
    func save(serie: Serie)
    func delete(serie: Int)
}

class SearchSerieTableViewCell: UITableViewCell {
    
    static let cellID = "cellSearchSerie"
    
    static var nib:UINib {
        return UINib(nibName: "SearchSerieTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var imgFavorite: UIImageView!
    
    let favoriteIcon = Constants.Images.Favorite.favorite
    let noFavoriteIcon = Constants.Images.Favorite.noFavorite
    
    var serie: Serie?
    
    var delegate: SearchFavoriteDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func favoriteAction(_ sender: UITapGestureRecognizer) {
        var image = UIImage()
        
        if sender.view?.tag == 0 {
            sender.view?.tag = 1
            image = favoriteIcon ?? UIImage()
            if serie != nil {
                delegate?.save(serie: serie!)
            }
        } else {
            sender.view?.tag = 0
            image = noFavoriteIcon ?? UIImage()
            if serie?.id != nil {
                delegate?.delete(serie: (serie?.id)!)
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
            imgFavorite.tag = 1
        } else {
            imgFavorite.image = noFavoriteIcon
            imgFavorite.tag = 0
        }
    }
    
}
