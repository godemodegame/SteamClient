import UIKit

protocol ProfileHeaderViewProtocol {
    var name: String? { get set }
    var imageUrl: URL? { get set }
    var state: Int { get set }
    var gamesCount: Int? { get set }
}

class ProfileHeaderView: UIView, ProfileHeaderViewProtocol {
    var imageUrl: URL? {
        didSet {
            if let url = self.imageUrl {
                self.imageView.load(url: url)
            }
        }
    }
    
    var state: Int = 0 {
        didSet {
            switch self.state {
            case 0:
                self.stateLabel.text = "Offline"
                self.stateColor = .gray
            case 1:
                self.stateLabel.text = "Online"
                self.stateColor = .blue
            case 2:
                self.stateLabel.text = "Busy"
                self.stateColor = .red
            case 3:
                self.stateColor = .orange
                self.stateLabel.text = "Away"
            case 4:
                self.stateColor = .blue
                self.stateLabel.text = "Snooze"
            case 5:
                self.stateColor = .blue
                self.stateLabel.text = "Looking to trade"
            case 6:
                self.stateColor = .green
                self.stateLabel.text = "Looking to play"
            default: self.stateColor = .gray
            }
        }
    }
    
    var gamesCount: Int? {
        didSet {
            self.gamesCountLabel.text = "Total games: \(self.gamesCount ?? 0)"
        }
    }
    
    var name: String? {
        didSet {
            self.nameLabel.text = self.name
        }
    }
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let stateLabel = UILabel()
    let gamesCountLabel = UILabel()
    var stateColor: UIColor? {
        didSet {
            self.imageView.layer.borderColor = self.stateColor?.cgColor
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupImageView()
        self.setupNameLabel()
        self.setupStateLabel()
        self.setupGamesCount()
    }
    
    private func setupGamesCount() {
        self.gamesCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.gamesCountLabel.textColor = .gray
        self.addSubview(self.gamesCountLabel)
        
        [
            self.gamesCountLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            self.gamesCountLabel.topAnchor.constraint(equalTo: self.stateLabel.bottomAnchor, constant: 5)
            ].forEach { $0.isActive = true }
    }
    
    private func setupStateLabel() {
        self.stateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.stateLabel.textColor = .gray
        self.addSubview(self.stateLabel)
        
        [
            self.stateLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            self.stateLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 5)
            ].forEach { $0.isActive = true }
    }
    
    private func setupNameLabel() {
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(self.nameLabel)
        
        [
            self.nameLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
            ].forEach { $0.isActive = true }
    }
    
    private func setupImageView() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.layer.borderColor = self.stateColor?.cgColor
        self.imageView.layer.borderWidth = 2
        self.addSubview(self.imageView)
        
        [
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.imageView.heightAnchor.constraint(equalToConstant: 140),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor)
            ].forEach { $0.isActive = true }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

