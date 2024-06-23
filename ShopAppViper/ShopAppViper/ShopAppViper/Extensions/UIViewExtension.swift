//
//  UIViewExtension.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 16.06.2024.
//

import Foundation
import UIKit

extension UIView {
    
    func setTop(equalTo : NSLayoutYAxisAnchor, constant : CGFloat = 0){
        self.topAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    func setBottom(equalTo : NSLayoutYAxisAnchor, constant : CGFloat = 0){
        self.bottomAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    func setLeft(equalTo : NSLayoutXAxisAnchor, constant : CGFloat = 0){
        self.leftAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    func setRight(equalTo : NSLayoutXAxisAnchor, constant : CGFloat = 0){
        self.rightAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    func setCenterX(equalTo : NSLayoutXAxisAnchor, constant : CGFloat = 0){
        self.centerXAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    func setCenterY(equalTo : NSLayoutYAxisAnchor, constant : CGFloat = 0){
        self.centerYAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    
    func setHeight(height : CGFloat){
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(width : CGFloat){
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setWidthAnchor(equalTo : NSLayoutDimension, constant : CGFloat = 0){
        self.widthAnchor.constraint(equalTo: equalTo).isActive = true
    }
    
    func setHeightAnchor(equalTo : NSLayoutDimension, constant : CGFloat = 0){
        self.heightAnchor.constraint(equalTo: equalTo).isActive = true
    }
}
