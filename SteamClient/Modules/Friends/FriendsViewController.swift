import UIKit

protocol FriendsViewProtocol: class {
    var viewModel: [Friend] { get set }
    func setupCell()
}

class FriendsViewController: UITableViewController {
    
    var viewModel: [Friend] = [] {
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
        cell.imgView.load(url: friend.littleAvatar)
        cell.state = friend.state
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: -LoginViewProtocol

extension FriendsViewController: FriendsViewProtocol {
    func setupCell() {
        self.tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "friendCell")
    }
}
