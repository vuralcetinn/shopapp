//
//  ProductDetailPresenter.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 15.06.2024.
//

import Foundation

protocol ProductDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class ProductDetailPresenter: ProductDetailPresenterProtocol {
    weak var view: ProductDetailViewProtocol?
    var interactor: ProductDetailInteractorInputProtocol?
    var router: ProductDetailRouterProtocol?
    var productId: Int?

    func viewDidLoad() {
        guard let productId = productId else { return }
        interactor?.fetchProductDetail(by: productId)
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    func didFetchProductDetail(_ productDetail: ProductDetail) {
        view?.showProductDetail(productDetail)
    }

    func didFailToFetchProductDetail(error: Error) {
        view?.showError(error.localizedDescription)
    }
}
