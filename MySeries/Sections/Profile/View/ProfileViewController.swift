//
//  ProfileViewController.swift
//  MySeries
//
//  Created by Leticia Echarri on 26/06/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

protocol ProfileViewControllerProtocol: ParentViewControllerProtocol {
}

class ProfileViewController: ParentViewController {
    
    let presenter: ProfilePresenterProtocol
    
    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "ProfileViewController", bundle: nil, presenterParent: presenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension ProfileViewController: ProfileViewControllerProtocol {
}
