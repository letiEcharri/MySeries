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
        let tap = UITapGestureRecognizer(target: self, action: #selector(favoriteAction(_:)))
        imgFavorite.addGestureRecognizer(tap)
    }
    
    @objc func favoriteAction(_ sender: UITapGestureRecognizer) {
        var image = UIImage()
        
        if sender.view?.tag == 0 {
            sender.view?.tag = 1
            image = UIImage(named: "favIconFull") ?? UIImage()
        } else {
            sender.view?.tag = 0
            image = UIImage(named: "favIcon") ?? UIImage()
        }
        
        if let favorite = sender.view as? UIImageView {
            favorite.image = image
        }
    }
    
    func set(serie: Serie, score: Double) {
        imgPicture.image = UIImage(named: serie.image.medium)
        lblTitle.text = serie.name
        
        var genres = ""
        for item in serie.genres {
            genres += "\(item) "
        }
        lblGenres.text = genres
        lblScore.text = score.format(f: ".2")
    }
    
}
