//
//  LanguagePickerView.swift
//  MySeries
//
//  Created by Leticia Echarri on 31/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

class LanguagePickerView: UIView {
    
    var picker = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.appColor.cgColor
        self.layer.cornerRadius = 10
        
        let toolbarHeight: CGFloat = 20
        
        let btnProfile = UIButton(frame: CGRect(x: 0, y: 0, width: toolbarHeight, height: toolbarHeight))
        btnProfile.setTitle("DONE", for: .normal)
        
        let btnDone = UIBarButtonItem(customView: btnProfile)
        let btnCancel = UIBarButtonItem(customView: btnProfile)
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 20, width: self.frame.width, height: toolbarHeight))
        toolbar.barStyle = .default
        toolbar.isTranslucent = false
        toolbar.items = [btnCancel, btnDone]
        toolbar.backgroundColor = .red
        toolbar.sizeToFit()
        self.addSubview(toolbar)
        
        picker.frame = CGRect(x: 0, y: toolbarHeight, width: self.frame.width, height: self.frame.height - toolbarHeight)
        picker.showsSelectionIndicator = true
        self.addSubview(picker)
    }
    
    @objc private func languageAction(_ sernder: UIBarButtonItem) {
        
    }
}
