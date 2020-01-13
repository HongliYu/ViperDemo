import UIKit

final class NewsDetailModuleBuilder {

    private let urlString: String

    init(urlString: String) {
        self.urlString = urlString
    }

    func build() -> UIViewController {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: String(describing: NewsDetailViewController.self)) as? NewsDetailViewController
            else { return UIViewController() }

        let router = NewsDetailRouter()
        router.viewController = viewController

        let presenter = NewsDetailPresenter(urlString: urlString)
        presenter.view = viewController
        presenter.router = router

        let interactor = NewsDetailInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter

        return viewController
    }

}
