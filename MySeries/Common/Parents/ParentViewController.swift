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
    
    let presenterParent: ParentPresenterProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(nibName: String, bundle: Bundle?, presenterParent: ParentPresenterProtocol?) {
        
        self.presenterParent = presenterParent != nil ? presenterParent : nil
        super.init(nibName: nibName, bundle: bundle)
    }
    
}

extension ParentViewController: ParentViewControllerProtocol {
}
