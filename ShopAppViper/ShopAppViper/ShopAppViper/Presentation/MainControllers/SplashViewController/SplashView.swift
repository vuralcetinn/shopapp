//
//  SplashView.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 17.07.2024.
//

import Foundation

import UIKit

class SplashView: UIView {
    
    lazy var splashImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "AppIcon")
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }

    // Setup your view components
    private func setupImageView() {
        backgroundColor = .white
        addSubview(splashImageView)
        splashImageView.setTop(equalTo: topAnchor)
        splashImageView.setBottom(equalTo: bottomAnchor)
        splashImageView.setRight(equalTo: rightAnchor)
        splashImageView.setLeft(equalTo: leftAnchor)
        

        
    }
}
