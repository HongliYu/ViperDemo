import Foundation

final class NewsInteractor: NewsInteractorInput {

    weak var output: NewsInteractorOutput!
    private var newsService: NewsService
    private var dataStorage: ArticleDataStorage

    init(newsService: NewsService, dataStorage: ArticleDataStorage) {
        self.newsService = newsService
        self.dataStorage = dataStorage
    }

    // MARK: - NewsInteractorInput
    func fetchNews() {
        newsService.fetchNews { [weak self] result in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                switch result {
                case .success(let articleList):
                    self?.output.didReceive(articleList)
                    guard let articles = articleList.articles else { return }
                    strongSelf.dataStorage.store(articles, completion: { _ in })
                case .failure(let error):
                    print(error ?? "error is nil")
                }
            }
        }
    }

    func fetchNewsHistory() {
        dataStorage.loadRecent(numerOfItems: 10) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    let articleList = ArticleList(status: "ok", totalResults: 10, articles: articles)
                    self?.output.didReceive(articleList)
                case .failure(let error):
                    print(error ?? "error is nil")
                }
            }
        }
    }

}
