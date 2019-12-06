import UIKit

protocol ProfileViewProtocol: class {
    var tableViewModel: [OwnedGameViewModel]? { get set }
    func setupBackground()
    func showLoginButton()
    func showLogoutButton()
    func setupHeader()
    func hideHeader()
    func setupTableView()
    func hideTableView()
    func setupFailGames()
    func hideFail()
}

class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenterProtocol!
    let configurator: ProfileConfiguratorProtocol = ProfileConfigurator()
    
    var tableViewModel: [OwnedGameViewModel]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //MARK: Views
    
    let headerView = ProfileHeaderView()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(self.logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(self.loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: UITableView.Style.grouped)
        view.register(GameTableViewCell.self, forCellReuseIdentifier: GameTableViewCell.reuseIdentifier)
        view.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var gameFailLabel: UILabel = {
        let label = UILabel()
        label.text = "Failed to load list of owned games"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("reload", for: .normal)
        button.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func loginButtonTapped() {
        self.presenter.loginButtonTapped()
    }
    
    @objc func logoutButtonTapped() {
        self.presenter.logoutButtonTapped()
    }
    
    @objc func reloadButtonTapped() {
        self.presenter.reload()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.configurator.configure(with: self)
        self.presenter.configureUserView()
    }
    
    init(friend: User? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.configurator.configure(with: self)
        if let friend = friend {
            self.presenter.configureFriendView(user: friend)
        } else {
            self.presenter.configureUserView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    func setupBackground() {
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }
    }
    
    func setupFailGames() {
        self.view.addSubview(self.gameFailLabel)
        self.view.addSubview(self.reloadButton)
        
        [self.gameFailLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
         self.gameFailLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
         
         self.reloadButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
         self.reloadButton.topAnchor.constraint(equalTo: self.gameFailLabel.bottomAnchor)
            ].forEach { $0.isActive = true}
    }
    
    func hideFail() {
        self.gameFailLabel.removeFromSuperview()
        self.reloadButton.removeFromSuperview()
    }
    
    func setupTableView() {
        self.view.addSubview(self.tableView)
        
        [self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
         self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
         self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
         self.tableView.topAnchor.constraint(equalTo: self.view.bottomAnchor)
            ].forEach { $0.isActive = true }
    }
    
    func hideTableView() {
        self.tableView.removeFromSuperview()
    }
    
    func setupHeader() {
        self.view.addSubview(self.headerView)

        if #available(iOS 11, *) {
            self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            self.headerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        }
        [self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
         self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
         self.headerView.heightAnchor.constraint(equalToConstant: 170)
            ].forEach { $0.isActive = true }
    }
    
    func hideHeader() {
        self.headerView.removeFromSuperview()
    }
    
    func showLoginButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.loginButton)
    }
    
    func showLogoutButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.logoutButton)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.reuseIdentifier, for: indexPath) as! GameTableViewCell
        if let viewModel = self.tableViewModel?[indexPath.item] {
            cell.ownedGameViewModel = viewModel
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
