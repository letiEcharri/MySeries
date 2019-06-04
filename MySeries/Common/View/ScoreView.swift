//
//  ScoreView.swift
//  MySeries
//
//  Created by Leticia Echarri on 04/06/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol ScoreViewDelegate {
    func save(score: Int)
}

class ScoreView: UIView {
    
    let total = 5
    var score = 0
    var stars: [UIButton] = [UIButton]()
    
    var delegate: ScoreViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView() {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        
        let btnSize = stackView.frame.height
        for item in 1...total {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: btnSize, height: btnSize))
            button.imageView?.contentMode = .scaleAspectFit
            button.tag = item
            button.setImage(UIImage(named: "starEmpty")?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = UIColor.appColor
            button.addTarget(self, action: #selector(starAction(_:)), for: .touchUpInside)
            
            stars.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func starAction(_ sender: UIButton) {
        
        for item in stars {
            if item.tag <= sender.tag {
                item.setImage(UIImage(named: "starFull")?.withRenderingMode(.alwaysTemplate), for: .normal)
                item.tintColor = UIColor.appColor
            } else {
                item.setImage(UIImage(named: "starEmpty")?.withRenderingMode(.alwaysTemplate), for: .normal)
                item.tintColor = UIColor.appColor
            }
        }
        
        score = sender.tag
        delegate?.save(score: sender.tag)
    }
    
    
    // MARK: Public functions
    func set(score: Int) {
        self.score = score
        
        for item in stars where (item.tag <= score) {
            item.setImage(UIImage(named: "starFull")?.withRenderingMode(.alwaysTemplate), for: .normal)
            item.tintColor = UIColor.appColor
        }
    }
}
