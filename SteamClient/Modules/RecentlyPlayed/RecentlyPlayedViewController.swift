import UIKit

protocol RecentlyPlayedViewProtocol: class {
    var tableViewModel: [RecentlyGameViewModel]? { get set }
    func setupTableView()
}

class RecentlyPlayedViewController: UITableViewController {
    
    var presenter: RecentlyPlayedPresenterProtocol!
    let configurator: RecentlyPlayedConfiguratorProtocol = RecentlyPlayedConfigurator()
    
    var tableViewModel: [RecentlyGameViewModel]? = nil {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: Views
    
    
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configurator.configure(with: self)
        self.presenter.configureView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewModel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.reuseIdentifier, for: indexPath) as! GameTableViewCell
        if let game = self.tableViewModel?[indexPath.item] {
            cell.recentlyGameViewModel = game
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: -LoginViewProtocol

extension RecentlyPlayedViewController: RecentlyPlayedViewProtocol {
    func setupTableView() {
        self.tableView.separatorStyle = .none
        self.tableView.register(GameTableViewCell.self, forCellReuseIdentifier: GameTableViewCell.reuseIdentifier)
    }
}
