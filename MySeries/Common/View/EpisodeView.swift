//
//  EpisodeView.swift
//  MySeries
//
//  Created by Leticia Echarri on 20/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol EpisodeViewDelegate {
    func clickEye(_ parameters: EpisodeView.Parameters)
    func clickView(_ parameters: EpisodeView.Parameters)
}

class EpisodeView: UIView {
    
    var lblTitle = UILabel()
    var btnEye = UIButton()
    
    var height: CGFloat = 25
    
    var delegate: EpisodeViewDelegate?
    
    struct Parameters {
        var episodeID: Int?
        var serieID: Int?
        
        init(episodeID: Int, serieID: Int) {
            self.episodeID = episodeID
            self.serieID = serieID
        }
    }
    var parameters: Parameters?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView() {
        // Self View
        height = self.frame.size.height
        self.isUserInteractionEnabled = true
        
        // Button Eye
        btnEye.frame = CGRect(x: self.frame.width - height, y: 0, width: height, height: height)
        btnEye.setBackgroundImage(UIImage(named: "noWatched"), for: .normal)
        btnEye.addTarget(self, action: #selector(clickEye(_:)), for: .touchUpInside)
        self.addSubview(btnEye)
        
        // Label
        lblTitle.frame = CGRect(x: 0, y: 0, width: self.frame.width-height, height: height)
        lblTitle.font = UIFont(name: "Noteworthy-Light", size: 15)
        lblTitle.textColor = .black
        lblTitle.text = "Título"
        self.addSubview(lblTitle)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickView(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc private func clickEye(_ sender: UIButton) {
        if let data = parameters {
            delegate?.clickEye(data)
        }
    }
    
    @objc private func clickView(_ sender: UITapGestureRecognizer) {
        if let data = parameters {
            delegate?.clickView(data)
        }
    }
    
    // MARK: Public functions
    
    func set(title: String) {
        lblTitle.text = title
    }
    
    func set(parameters: Parameters) {
        self.parameters = parameters
    }
}
