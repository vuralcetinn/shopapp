protocol ProductPresenterProtocol: AnyObject {
    func viewDidLoad(paging: Int)
    func didSelectProduct(_ productId: Int)
    func fetchPaging(paging: Int)
}

class ProductPresenter: ProductPresenterProtocol {
    weak var view: ProductViewProtocol?
    var interactor: ProductInteractorInputProtocol?
    var router: ProductRouterProtocol?

    func viewDidLoad(paging: Int) {
        interactor?.fetchProducts(paging: paging)
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
        view?.showProducts(productList.products ?? [])
    }

    func didFetchSponsoredProducts(_ productList: ProductListModel) {
        view?.showSponsoredProducts(productList.sponsoredProducts ?? [])
    }
    func didFailToFetchProducts(error: Error) {
        view?.showError(error.localizedDescription)
    }
}
