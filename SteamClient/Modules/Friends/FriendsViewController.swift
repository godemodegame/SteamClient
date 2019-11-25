import UIKit

protocol FriendsViewProtocol: class {
    var viewModel: [User] { get set }
    func setupCell()
}

class FriendsViewController: UITableViewController {
    
    var viewModel: [User] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var presenter: FriendsPresenterProtocol!
    let configurator: FriendsConfiguratorProtocol = FriendsConfigurator()
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configurator.configure(with: self)
        self.presenter.configureView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell
        let friend = viewModel[indexPath.item]
        cell.namelabel.text = friend.name
        if let url = friend.littleAvatar {
            cell.imgView.load(url: url)
        }
        cell.state = friend.state ?? 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.presenter.tappedRow(with: self.viewModel[indexPath.item])
    }
}

// MARK: -LoginViewProtocol

extension FriendsViewController: FriendsViewProtocol {
    func setupCell() {
        self.tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "friendCell")
    }
}
