//
//  ParentViewController.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol ParentViewControllerProtocol {
    func showSpinner()
}

class ParentViewController: UIViewController {
    
    let presenterParent: ParentPresenterProtocol?
    
    var spinnerView : UIView?
    private var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(nibName: String, bundle: Bundle?, presenterParent: ParentPresenterProtocol?) {
        
        self.presenterParent = presenterParent != nil ? presenterParent : nil
        super.init(nibName: nibName, bundle: bundle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
}
