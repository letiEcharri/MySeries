//
//  LanguagePickerView.swift
//  MySeries
//
//  Created by Leticia Echarri on 31/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol LanguagePickerViewDelegate {
    func done()
    func cancel()
}

class LanguagePickerView: UIView {
    
    var picker = UIPickerView()
    
    var delegate: LanguagePickerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(frame: CGRect) {
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.appColor.cgColor
        self.layer.cornerRadius = 10
        
        picker.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        picker.showsSelectionIndicator = true
        self.addSubview(picker)
        
        let btnDone = UIButton(frame: CGRect(x: frame.width - 105, y: 5, width: 100, height: 20))
        btnDone.setTitle("common.done".localize.uppercased(), for: .normal)
        btnDone.tag = 0
        
        let btnCancel = UIButton(frame: CGRect(x: 5, y: 5, width: btnDone.frame.width, height: btnDone.frame.height))
        btnCancel.setTitle("common.cancel".localize.uppercased(), for: .normal)
        btnCancel.tag = 1
        
        let buttons = [btnDone, btnCancel]
        for item in buttons {
            item.titleLabel?.font =  UIFont().appFont(type: .bold, size: 15)
            item.backgroundColor = UIColor.appColor
            item.setCorner(radius: 10, color: btnDone.backgroundColor!, width: 1)
            item.addTarget(self, action: #selector(languageAction(_:)), for: .touchUpInside)
            self.addSubview(item)
        }
    }
    
    @objc private func languageAction(_ sender: UIButton) {

        if sender.tag == 1 {
            delegate?.cancel()
        } else {
            delegate?.done()
        }
    }
}
