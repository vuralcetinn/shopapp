//
//  ProductInteractor.swift
//  ShopAppViper
//
//  Created by TCMX-MOBILE-VC on 14.06.2024.
//

import Foundation

protocol ProductInteractorInputProtocol: AnyObject {
    func fetchProducts(paging: Int)
}

protocol ProductInteractorOutputProtocol: AnyObject {
    func didFetchProducts(_ productList: ProductListModel)
    func didFailToFetchProducts(error: Error)
}


class ProductInteractor: ProductInteractorInputProtocol {
    weak var presenter: ProductInteractorOutputProtocol?
    var productServiceHelper = ProductServiceHelper()

    func fetchProducts(paging: Int) {
        productServiceHelper.fetchProducts(paging: paging) { result in
            switch result {
            case .success(let productListModel):
                self.presenter?.didFetchProducts(productListModel)
            case .failure(let error):
                self.presenter?.didFailToFetchProducts(error: error)
            }
        }
    }
}
