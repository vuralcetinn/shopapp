//
//  ToolbarViewExt.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 24.07.2024.
//

import Foundation
import UIKit

class ToolbarView : UIView {
    
    var toolbarTitle: String? {
            didSet {
                toolbarTitleLabel.text = toolbarTitle
            }
        }
    
    lazy var mainContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var toolbarTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Wireframe"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var toolbarBackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var toolbarLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainContentView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMainContentView()
    }

    // Setup your view components
    private func setupMainContentView() {
        backgroundColor = .white
        addSubview(mainContentView)
        mainContentView.setRight(equalTo: rightAnchor)
        mainContentView.setLeft(equalTo: leftAnchor)
        mainContentView.setHeight(height: 40)
        
        setUpTitleLabel()
        setupBackButton()
        setupLineView()
    }
    
    private func setupBackButton() {
        mainContentView.addSubview(toolbarBackButton)
        toolbarBackButton.setLeft(equalTo: leftAnchor,constant: 20)
        toolbarBackButton.setCenterY(equalTo: mainContentView.centerYAnchor)
        toolbarBackButton.setHeight(height: 25)
        toolbarBackButton.setWidth(width: 25)
    }
    
    private func setUpTitleLabel() {
        mainContentView.addSubview(toolbarTitleLabel)
        toolbarTitleLabel.setCenterX(equalTo: mainContentView.centerXAnchor)
        toolbarTitleLabel.setCenterY(equalTo: mainContentView.centerYAnchor)
    }
    
    private func setupLineView() {
        mainContentView.addSubview(toolbarLineView)
        toolbarLineView.setTop(equalTo: toolbarTitleLabel.bottomAnchor,constant: 15)
        toolbarLineView.setLeft(equalTo: leftAnchor)
        toolbarLineView.setRight(equalTo: rightAnchor)
        toolbarLineView.setHeight(height: 1)
    }

}

