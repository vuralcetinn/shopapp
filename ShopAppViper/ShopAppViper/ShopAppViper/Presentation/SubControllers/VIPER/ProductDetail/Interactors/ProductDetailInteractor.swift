import Foundation

protocol ProductDetailInteractorInputProtocol: AnyObject {
    func fetchProductDetail(by id: Int)
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    func didFetchProductDetail(_ productDetail: ProductDetail)
    func didFailToFetchProductDetail(error: Error)
}

class ProductDetailInteractor: ProductDetailInteractorInputProtocol {
    weak var presenter: ProductDetailInteractorOutputProtocol?
    let urlString = "http://private-d3ae2-n11case.apiary-mock.com/product?productId="
    var productServiceHelper = ProductServiceHelper()

    func fetchProductDetail(by id: Int) {
        productServiceHelper.fetchProductDetail(by: id) { result in
            switch result {
            case .success(let productDetail):
                self.presenter?.didFetchProductDetail(productDetail)
            case .failure(let error):
                self.presenter?.didFailToFetchProductDetail(error: error)
            }
        }
    }
}

