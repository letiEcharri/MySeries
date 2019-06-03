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
    
//    var languagePicker: UIPickerView = UIPickerView()
    var languagePicker: LanguagePickerView?
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
    
//    func reload() {
//        
//    }
    
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
        let langView = FlagButtonView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        langView.flag.image = Language.getCurrent().flag
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeLanguageAction(_:)))
        langView.addGestureRecognizer(tap)
        
        self.navigationController?.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: langView)
    }
    
    @objc private func changeLanguageAction(_ sender: UITapGestureRecognizer) {
        configureLanguagePicker()
    }
    
    private func configureLanguagePicker() {
        let height: CGFloat = CGFloat(languages.count * 50) + 20
        languagePicker = LanguagePickerView(frame: CGRect(x: 20, y: (self.view.frame.size.height - height - 100),
                                                          width: self.view.frame.width - 40,
                                                          height: height))
        
        languagePicker?.delegate = self
        languagePicker?.picker.delegate = self
        languagePicker?.picker.dataSource = self
        
        self.view.addSubview(languagePicker!)

        var cont = 0
        for item in languages {
            if item.code == Language.getLanguage() {
                languagePicker?.picker.selectRow(cont, inComponent: 0, animated: true)
            }
            cont += 1
        }
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
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label:UILabel
        
        if let v = view as? UILabel{
            label = v
        }
        else{
            label = UILabel()
        }
        
        label.textColor = .black
        label.font = UIFont().appFont(type: .light, size: 25)
        label.textAlignment = .center
        label.text = languages[row].name
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}

extension ParentViewController: LanguagePickerViewDelegate {
    func done() {
        let row = languages[(languagePicker?.picker.selectedRow(inComponent: 0))!]
        Bundle.set(language: row)
        presenterParent?.restartApp()
    }
    
    func cancel() {
        languagePicker?.removeFromSuperview()
    }
}
