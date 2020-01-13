import UIKit

final class NewsRouter: NewsRouterInput {

	weak var viewController: UIViewController!

    func displayNewsDetails(urlString: String) {
        let builder = NewsDetailModuleBuilder(urlString: urlString)
        let newsDetailViewController = builder.build()

        viewController.title = ""
        viewController.navigationController?.pushViewController(newsDetailViewController, animated: true)
    }

}
