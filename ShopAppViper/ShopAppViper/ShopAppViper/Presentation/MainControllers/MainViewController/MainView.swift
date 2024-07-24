//
//  MainView.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 18.07.2024.
//

import Foundation

import UIKit

class MainView: UIView {
    
    lazy var mainContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var toolbarView: ToolbarView = {
       let view = ToolbarView()
        view.toolbarTitle = "Wireframexx"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var firstButtonView: UIButton = {
        let button = UIButton()
        button.setTitle("Test", for: .normal)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(mainContentView)
        mainContentView.setTop(equalTo: topAnchor)
        mainContentView.setBottom(equalTo: bottomAnchor)
        mainContentView.setRight(equalTo: rightAnchor)
        mainContentView.setLeft(equalTo: leftAnchor)
        
        setupToolbarView()
        setUpButtonView()
    }
    
    private func setupToolbarView() {
        mainContentView.addSubview(toolbarView)
        toolbarView.setTop(equalTo: topAnchor,constant: 60)
        toolbarView.setLeft(equalTo: leftAnchor)
        toolbarView.setRight(equalTo: rightAnchor)
    }
    
    private func setUpButtonView() {
        mainContentView.addSubview(firstButtonView)
        firstButtonView.setTop(equalTo: toolbarView.topAnchor,constant: 120)
        firstButtonView.setLeft(equalTo: mainContentView.leftAnchor,constant: 20)
        firstButtonView.setRight(equalTo: mainContentView.rightAnchor,constant: -20)
        firstButtonView.setHeight(height: 40)
    }
}
