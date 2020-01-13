final class NewsPresenter: NewsViewOutput, NewsInteractorOutput {

    weak var view: NewsViewInput!
    var interactor: NewsInteractorInput!
    var router: NewsRouterInput!

    // MARK: - NewsViewOutput
    func viewIsReady() {
        interactor.fetchNewsHistory()
        interactor.fetchNews()
    }

    // MARK: - NewsInteractorOutput
    func didReceive(_ articleList: ArticleList) {
        var newsCellModels = [NewsCellModel]()
        guard let articles = articleList.articles else {
            return
        }
        newsCellModels = articles.compactMap { NewsCellModel(article: $0) }
        view.display(newsCellModels)
    }

    func didSelect(_ cellModel: NewsCellModel) {
        guard let urlString = cellModel.url else { return }
        router.displayNewsDetails(urlString: urlString)
    }

}
