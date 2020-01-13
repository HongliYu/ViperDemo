import UIKit

final class NewsModuleBuilder {

    func build() -> UIViewController {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: String(describing: NewsViewController.self)) as? NewsViewController else {
                return UIViewController()
        }

        let router = NewsRouter()
        router.viewController = viewController

        let presenter = NewsPresenter()
        presenter.view = viewController
        presenter.router = router

        let coreDataManager = CoreDataManager.shared
        let dataStorage = CoreDataArticleStorage(manager: coreDataManager)

        let interactor = NewsInteractor(newsService: NewsServiceImpl(),
                                        dataStorage: dataStorage)
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter

        return viewController
    }

}
