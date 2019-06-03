//
//  FlagButtonView.swift
//  MySeries
//
//  Created by Leticia Echarri on 03/06/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

class FlagButtonView: UIView {
    
    var flag = UIImageView()
    var arrow = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        flag.frame = CGRect(x: 0, y: 0, width: self.frame.width - 10, height: self.frame.height)
        flag.contentMode = .scaleAspectFit
        addSubview(flag)
        
        arrow.frame = CGRect(x: flag.frame.width, y: 0, width: 10, height: self.frame.height)
        arrow.contentMode = .scaleAspectFit
        arrow.image = UIImage(named: "downArrowWhite")
        addSubview(arrow)
    }
}
