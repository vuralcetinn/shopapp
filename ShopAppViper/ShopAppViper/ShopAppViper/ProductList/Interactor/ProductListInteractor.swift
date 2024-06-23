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
    func didFetchSponsoredProducts(_ productList: ProductListModel)

}

class ProductInteractor: ProductInteractorInputProtocol {
    weak var presenter: ProductInteractorOutputProtocol?

    func fetchProducts(paging: Int) {
        
        if paging < 3 {
            let urlString = "https://private-d3ae2-n11case.apiary-mock.com/listing/\(paging)"

            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    self.presenter?.didFailToFetchProducts(error: error)
                    return
                }

                guard let data = data else {
                    print("No data")
                    return
                }

                do {
                    let productListModel = try JSONDecoder().decode(ProductListModel.self, from: data)
                    self.presenter?.didFetchProducts(productListModel)
                    self.presenter?.didFetchSponsoredProducts(productListModel)
                } catch {
                    self.presenter?.didFailToFetchProducts(error: error)
                }
            }

            task.resume()
        }
        
    }
}
