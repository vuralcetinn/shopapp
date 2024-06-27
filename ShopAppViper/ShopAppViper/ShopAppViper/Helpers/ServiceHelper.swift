import Foundation

class ProductServiceHelper {
    var baseUrl = ServiceConfig.shared.baseUrl

    func fetchProductDetail(by id: Int, completion: @escaping (Result<ProductDetail, Error>) -> Void) {
            let urlString = "http://private-d3ae2-n11case.apiary-mock.com/product?productId=\(id)"
            
            guard let url = URL(string: urlString) else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data", code: 1, userInfo: nil)))
                    return
                }
                
                do {
                    let productDetail = try JSONDecoder().decode(ProductDetail.self, from: data)
                    completion(.success(productDetail))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    

    func fetchProducts(paging: Int, completion: @escaping (Result<ProductListModel, Error>) -> Void) {
        
        var urlString = baseUrl + "/listing/\(paging)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No data")
                completion(.failure(NSError(domain: "No data", code: 1, userInfo: nil)))
                return
            }

            do {
                let productListModel = try JSONDecoder().decode(ProductListModel.self, from: data)
                completion(.success(productListModel))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

