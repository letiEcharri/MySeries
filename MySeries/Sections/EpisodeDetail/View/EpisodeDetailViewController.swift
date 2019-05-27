//
//  EpisodeDetailViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol EpisodeDetailViewControllerProtocol {
}

class EpisodeDetailViewController: ParentViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lblSeason: UILabel!
    @IBOutlet weak var lblEpisode: UILabel!
    @IBOutlet weak var lblRelease: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblRuntime: UILabel!
    @IBOutlet weak var txtSumary: UITextView!
    @IBOutlet weak var btnWatched: UIButton!
    
    var episode: Episode?
    var serieID: Int?
    
    let presenter: EpisodeDetailPresenterProtocol
    
    init(presenter: EpisodeDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "EpisodeDetailViewController", bundle: nil, presenterParent: presenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func watchedAction(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.tag = 1
            sender.setBackgroundImage(UIImage(named: "eyeIcon"), for: .normal)
            if episode != nil {
                presenter.watch(episode: episode!, value: true, serieID: serieID ?? 0)
            }
        } else {
            sender.tag = 0
            sender.setBackgroundImage(UIImage(named: "noWatched"), for: .normal)
            if episode != nil {
                presenter.watch(episode: episode!, value: false, serieID: serieID ?? 0)
            }
        }
    }
}

extension EpisodeDetailViewController: EpisodeDetailViewControllerProtocol {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showBackButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = episode?.name ?? ""
        imgPicture.imageFromUrl(urlString: episode?.image?.medium ?? "")
        lblSeason.text = "Temporada: \(episode?.season ?? 0)"
        lblEpisode.text = "Episodio: \(episode?.number ?? 0)"
        lblRelease.text = "Estreno: \(episode?.airdate?.formatDate() ?? "")"
        lblHour.text = "Hora: \(episode?.airtime ?? "")"
        lblRuntime.text = "\(episode?.runtime ?? 0) min"
        txtSumary.text = episode?.summary?.htmlToString
        
        var imageWatched = UIImage()
        presenter.isWatched(episodeID: (episode?.id)!) { (response) in
            (response) ? (imageWatched = Constants.Images.Episode.watched ?? UIImage()) : (imageWatched = Constants.Images.Episode.unwatched ?? UIImage())
            
            self.btnWatched.setBackgroundImage(imageWatched, for: .normal)
            self.btnWatched.tag = (response) ? 1 : 0
        }  
    }
    
    
}
