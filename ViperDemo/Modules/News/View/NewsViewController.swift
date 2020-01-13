import UIKit

final class NewsViewController: UIViewController, NewsViewInput {

    var output: NewsViewOutput!
    private var cellModels: [NewsCellModel] = []
    @IBOutlet weak var tableView: UITableView!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        basicUI()
        output.viewIsReady()
    }

    private func basicUI() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        tableView.accessibilityIdentifier = "NewsTableView"
    }

    // MARK: NewsViewInput
    func display(_ cellModels: [NewsCellModel]) {
        self.cellModels = cellModels
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

// MARK: - Table view datasource/delegate
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTableViewCell.self),
                                                       for: indexPath) as? NewsTableViewCell else {
             return UITableViewCell()
        }
        cell.bindData(cellModels[indexPath.row])
        cell.accessibilityIdentifier = "NewsCell\(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        output.didSelect(cellModels[indexPath.row])
    }

}
