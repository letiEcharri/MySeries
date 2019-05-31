//
//  SerieDetailViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol SerieDetailViewControllerProtocol {
    func getViewController() -> SerieDetailViewController
}

class SerieDetailViewController: ParentViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblRuntime: UILabel!
    @IBOutlet weak var lblSumary: UITextView!
    @IBOutlet weak var lblPremiere: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    
    @IBOutlet weak var lblTextGender: UILabel! {
        didSet {
            lblTextGender.text = "common.genre".localize + ":"
        }
    }
    
    @IBOutlet weak var btnCast: UIButton! {
        didSet {
            btnCast.layer.borderWidth = 1
            btnCast.layer.borderColor = UIColor.black.cgColor
            btnCast.layer.cornerRadius = 10
            btnCast.setTitle("common.cast".localize.uppercased(), for: .normal)
        }
    }
    @IBOutlet weak var btnEpisodes: UIButton!{
        didSet {
            btnEpisodes.setTitle("common.episodes".localize.uppercased(), for: .normal)
        }
    }
    
    var serie: Serie?
    
    let presenter: SerieDetailPresenterProtocol
    
    init(presenter: SerieDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "SerieDetailViewController", bundle: nil, presenterParent: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func episodesAction(_ sender: UIButton) {
        presenter.navigateToSeasons(serie: serie?.id ?? 0)
    }
    
    @IBAction func castAction(_ sender: UIButton) {
        presenter.openCast(serieID: serie?.id ?? 0)
    }
    
}

extension SerieDetailViewController: SerieDetailViewControllerProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showBackButton()
        
        lblName.text = serie?.name?.uppercased()
        imgPicture.imageFromUrl(urlString: serie?.image?.medium ?? "")
        lblRating.text = String(format:"%.2f", serie?.rating?.average ?? 0)
        lblCountry.text = serie?.network?.country.name ?? ""
        lblLanguage.text = serie?.language ?? ""
        lblStatus.text = serie?.statusSerie ?? ""
        lblRuntime.text = "\(serie?.runtime ?? 0) min"
        lblSumary.text = (serie?.summary ?? "").htmlToString
        let date = serie?.premiered ?? ""
        lblPremiere.text = "common.premiere".localize + ": \(date.formatDate())"
        
        var genres = ""
        for item in (serie?.genres)! {
            genres += "\(item) "
        }
        lblGenres.text = genres
    }
    
    func getViewController() -> SerieDetailViewController {
        return self
    }
}
