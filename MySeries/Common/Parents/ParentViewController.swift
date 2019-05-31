//
//  ParentViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol ParentViewControllerProtocol {
}

class ParentViewController: UIViewController {
    
    var spinnerView : UIView?
    private var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    var languagePicker: UIPickerView = UIPickerView()
    var languages: [Language] = [.english, .spanish]
    
    let presenterParent: ParentPresenterProtocol?
    
    init(nibName: String, bundle: Bundle?, presenterParent: ParentPresenterProtocol?) {
        
        self.presenterParent = presenterParent != nil ? presenterParent : nil
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .bottom
        self.definesPresentationContext = true
        
        navigationBar()
    }
    
    @objc private func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ParentViewController: ParentViewControllerProtocol {
    func showSpinner() {
        spinnerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        spinnerView!.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinnerView!.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: (spinnerView?.centerXAnchor)!).isActive = true
        spinner.centerYAnchor.constraint(equalTo: (spinnerView?.centerYAnchor)!).isActive = true
        
        self.view.addSubview(spinnerView!)
    }
    
    func removeSpinner() {
        spinnerView?.removeFromSuperview()
    }
    
    func showBackButton() {
        let iconButton = UIButton(type: .system)
        iconButton.setImage(UIImage(named: "backWhite"), for: .normal)
        iconButton.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: iconButton)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        self.navigationController?.tabBarController?.navigationItem.leftBarButtonItem = menuBarItem
    }
    
    func hideBackButton() {
        self.navigationController?.tabBarController?.navigationItem.leftBarButtonItem = nil
    }
    
    private func navigationBar() {
        
        let languageButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(changeLanguageAction(_:)))
        self.navigationController?.tabBarController?.navigationItem.rightBarButtonItem = languageButton
    }
    
    @objc private func changeLanguageAction(_ sender: UIBarButtonItem) {
//        var language: [Language] = [.english, .spanish]
//        
//        Bundle.set(language: .spanish)
//        presenterParent?.restartApp()
        
        configureLanguagePicker()
    }
    
    private func configureLanguagePicker() {
        languagePicker.delegate = self
        languagePicker.dataSource = self
        languagePicker.showsSelectionIndicator = true
        let height: CGFloat = CGFloat(languages.count * 50)
        languagePicker.frame = CGRect(x: 20, y: (self.view.frame.size.height - height - 100), width: self.view.frame.width - 40, height: height)
        languagePicker.layer.borderColor = UIColor.appColor.cgColor
        languagePicker.layer.borderWidth = 1
        languagePicker.layer.cornerRadius = 10
        
        self.view.addSubview(languagePicker)
        
        var cont = 0
        for item in languages {
            if item.code == Language.getLanguage() {
                languagePicker.selectRow(cont, inComponent: 0, animated: true)
            }
            cont += 1
        }
    }
    
    @objc private func languageAction(_ sernder: UIBarButtonItem) {
        
    }
}

extension ParentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return languages[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(languages[row].name)
        
        Bundle.set(language: languages[row])
        presenterParent?.restartApp()
    }
}
