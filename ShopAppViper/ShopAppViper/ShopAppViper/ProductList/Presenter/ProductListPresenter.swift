protocol ProductPresenterProtocol: AnyObject {
    func didSelectProduct(_ productId: Int)
    func fetchPaging(paging: Int)
    func getProductsCount() -> Int
    func getSponsoredProductsCount() -> Int
    func getProductByIndex(index: Int) -> Product
    func getSponsoredProductByIndex(index: Int) -> Product
}

class ProductPresenter: ProductPresenterProtocol {
    
    
    
    
    weak var view: ProductViewProtocol?
    var interactor: ProductInteractorInputProtocol?
    var router: ProductRouterProtocol?
    
    var products: [Product] = []
    var sponsoredProducts: [Product] = []
    
    func getProductsCount() -> Int {
        return products.count
    }
    
    func getSponsoredProductsCount() -> Int {
        return sponsoredProducts.count
    }
    
    func getProductByIndex(index: Int) -> Product {
        return products[index]
    }
    
    func getSponsoredProductByIndex(index: Int) -> Product {
        return sponsoredProducts[index]
    }
    
    func fetchPaging(paging: Int) {
        interactor?.fetchProducts(paging: paging)
    }

    func didSelectProduct(_ productId: Int) {
        router?.navigateToProductDetail(from: view!, productId: productId)
    }
}

extension ProductPresenter: ProductInteractorOutputProtocol {
    func didFetchProducts(_ productList: ProductListModel) {
        self.products.append(contentsOf: productList.products ?? []) 
        self.sponsoredProducts.append(contentsOf: productList.sponsoredProducts ?? [])
        view?.reloadDatas()
    }

    func didFailToFetchProducts(error: Error) {
        view?.showError(error.localizedDescription)
    }
}
