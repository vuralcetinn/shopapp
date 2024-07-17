//
//  MainViewController.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 17.07.2024.
//


import Foundation
import UIKit

class MainViewController: UIViewController {
    let mainView = MainView()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true    
        // Set up the view
        view.backgroundColor = .white
        
        // Add splashImageView to the view
        
       
    }
    
    override func loadView() {
        self.view = mainView
    }
}
