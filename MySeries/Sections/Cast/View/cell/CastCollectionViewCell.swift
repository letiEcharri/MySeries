//
//  CastCollectionViewCell.swift
//  MySeries
//
//  Created by Leticia Echarri on 28/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    static let cellID = "castCell"
    
    static var nib:UINib {
        return UINib(nibName: "CastCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCharacter: UILabel!
    @IBOutlet weak var imgPicture: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureView()
    }
    
    private func configureView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5
    }
    
    func set(cast: Cast) {
        lblName.text = cast.person.name
        lblCharacter.text = cast.character.name
        
        if let image = cast.person.image?.medium {
            imgPicture.imageFromUrl(urlString: image)
        }
    }

}
