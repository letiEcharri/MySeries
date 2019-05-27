//
//  SerieListTableViewCell.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

class SerieListTableViewCell: UITableViewCell {
    
    static let cellID = "seriesCell"
    
    static var nib:UINib {
        return UINib(nibName: "SerieListTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var lblName: UILabel!
    var idSerie: Int = 0
    
}
