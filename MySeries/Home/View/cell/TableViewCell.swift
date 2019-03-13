//
//  TableViewCell.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var episodesView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func set(episodes: [Episode]) {
        if episodes.count > 0 {
            let height = episodesView.frame.height/3
            var cont = 0
            for item in episodes {
                if cont < 3 {
                    let newE = UILabel(frame: CGRect(x: 0, y: height * CGFloat(cont), width: episodesView.frame.width, height: height))
                    newE.text = item.name
                    newE.font = UIFont(name: "Noteworthy-Light", size: 14)
                    episodesView.addSubview(newE)
                }
                cont += 1
            }
        }
    }
    
}
