final class NewsDetailPresenter: NewsDetailViewOutput, NewsDetailInteractorOutput {

    private(set) var urlString: String
    weak var view: NewsDetailViewInput!
    var interactor: NewsDetailInteractorInput!
    var router: NewsDetailRouterInput!

    init(urlString: String) {
        self.urlString = urlString
    }

    // MARK: - NewsDetailViewOutput
    func viewIsReady() {
        view.display(urlString: urlString)
    }

    // MARK: - NewsDetailInteractorOutput

}
