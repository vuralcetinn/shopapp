//
//  ProductDetailRouter.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 15.06.2024.
//

import UIKit

protocol ProductDetailRouterProtocol: AnyObject {
    static func createProductDetailModule(productId: Int) -> UIViewController
}

class ProductDetailRouter: ProductDetailRouterProtocol {
    static func createProductDetailModule(productId: Int) -> UIViewController {
        let view = ProductDetailViewController()
        let presenter = ProductDetailPresenter()
        let interactor = ProductDetailInteractor()
        let router = ProductDetailRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.productId = productId
        interactor.presenter = presenter

        return view
    }
}
