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

    func fetchProductDetail(by id: Int) {
        let fullUrlString = "\(urlString)/\(id)"
        guard let url = URL(string: fullUrlString) else {
            print("Invalid URL")
            return
        }
        print(url)

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print(fullUrlString)
                    self.presenter?.didFailToFetchProductDetail(error: error)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    print("No data")
                }
                return
            }

            do {
                let productDetail = try JSONDecoder().decode(ProductDetail.self, from: data)
                DispatchQueue.main.async {
                    self.presenter?.didFetchProductDetail(productDetail)
                }
            } catch {
                DispatchQueue.main.async {
                    self.presenter?.didFailToFetchProductDetail(error: error)
                }
            }
        }

        task.resume()
    }
}
