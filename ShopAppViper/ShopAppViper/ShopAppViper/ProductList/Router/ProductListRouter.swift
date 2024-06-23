import UIKit

protocol ProductRouterProtocol: AnyObject {
    static func createProductModule() -> UIViewController
    func navigateToProductDetail(from view: ProductViewProtocol, productId: Int)
}

class ProductRouter: ProductRouterProtocol {
    static func createProductModule() -> UIViewController {
        let view = ProductViewController()
        let presenter = ProductPresenter()
        let interactor = ProductInteractor()
        let router = ProductRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }

    func navigateToProductDetail(from view: ProductViewProtocol, productId: Int) {
        let productDetailVC = ProductDetailRouter.createProductDetailModule(productId: productId)

        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(productDetailVC, animated: true)
        }
    }
}
