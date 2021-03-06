//
//  TableViewCell.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate {
    func click(episode: Episode, serieID: Int, seasonNumberEpisodes: Int)
}

class TableViewCell: UITableViewCell {
    
    static let cellID = "homeCell"
    
    static var nib:UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var episodesView: UIView!
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.borderColor = UIColor.appColor.cgColor
            containerView.layer.borderWidth = 1
            containerView.layer.cornerRadius = 10.0
            containerView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var lblEpisodeTop: UILabel!
    @IBOutlet weak var lblEpisodeCenter: UILabel!
    @IBOutlet weak var lblEpisodeBottom: UILabel!
    
    var delegate: TableViewCellDelegate?
    
    var episodes = [Episode]()
    var serie: Serie?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addButtonWith(label: UILabel) {
        let button = UIButton(frame: CGRect(x: 0, y: label.frame.origin.y, width: label.frame.width, height: label.frame.height))
        button.addTarget(self, action: #selector(goToDetailAction(_:)), for: .touchUpInside)
        containerView.addSubview(button)
    }
    
    @objc func goToDetailAction(_ sender: UITapGestureRecognizer) {
        for item in episodes where (item.id == sender.view?.tag) {
            delegate?.click(episode: item, serieID: serie?.id ?? 0, seasonNumberEpisodes: episodes.count)
        }
    }
    
    func set(serie: Serie) {
        self.serie = serie
        
        lblTitle.text = serie.name
        imgPicture.imageFromUrl(urlString: serie.image?.medium ?? "")
    }
    
    func set(episodes: [Episode]) {
        self.episodes = episodes
        
        if episodes.count > 0 {
            
            lblEpisodeTop.text = "\(episodes[0].season ?? 0) x \(episodes[0].number ?? 0) - \(episodes[0].name ?? "")"
            lblEpisodeTop.isHidden = false
            lblEpisodeTop.tag = episodes[0].id
            let tap1 = UITapGestureRecognizer(target: self, action: #selector(goToDetailAction(_:)))
            lblEpisodeTop.addGestureRecognizer(tap1)
            
            if episodes.count >= 2 {
                lblEpisodeCenter.text = "\(episodes[1].season ?? 0) x \(episodes[1].number ?? 0) - \(episodes[1].name ?? "")"
                lblEpisodeCenter.isHidden = false
                lblEpisodeCenter.tag = episodes[1].id
                let tap2 = UITapGestureRecognizer(target: self, action: #selector(goToDetailAction(_:)))
                lblEpisodeCenter.addGestureRecognizer(tap2)
            }
            if episodes.count >= 3 {
                lblEpisodeBottom.text = "\(episodes[2].season ?? 0) x \(episodes[2].number ?? 0) - \(episodes[2].name ?? "")"
                lblEpisodeBottom.isHidden = false
                lblEpisodeBottom.tag = episodes[2].id
                let tap3 = UITapGestureRecognizer(target: self, action: #selector(goToDetailAction(_:)))
                lblEpisodeBottom.addGestureRecognizer(tap3)
            }
        }
    }
    
}
