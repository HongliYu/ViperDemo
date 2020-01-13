import UIKit
import WebKit

final class NewsDetailViewController: UIViewController, NewsDetailViewInput {

    @IBOutlet weak var webView: WKWebView!
    var output: NewsDetailViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        basicUI()
        output.viewIsReady()
    }

    func basicUI() {
        webView.accessibilityIdentifier = "NewsDetailsWebView"
    }

    // MARK: NewsDetailViewInput
    func display(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }

}
