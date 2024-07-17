import UIKit

protocol Router {
    func navigate(to destination: Destination)
}

class AppRouter: Router {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func navigate(to destination: Destination) {
        
        guard let navigationController = navigationController else {
                    print("Navigation controller is nil.")
                    return
                }
        // Yönlendirme mantığı
        switch destination {
        case .main:
            let mainVC = MainViewController()
            mainVC.title = "Wireframe"
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
}

enum Destination {
    case main
}
