//
//  SplashViewController.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 17.07.2024.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    let splashView = SplashView()
    
    var router: Router?

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the view
        view.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.router?.navigate(to: .main)
         
        }
        
        // Add splashImageView to the view
        
       
    }
    
    override func loadView() {
        self.view = splashView
    }
}
