import UIKit

protocol ProfileHeaderViewProtocol {
    var name: String? { get set }
    var imageUrl: URL? { get set }
    var state: Int { get set }
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
            case 1: self.stateColor = .blue
            case 2: self.stateColor = .red
            case 3, 4: self.stateColor = .orange
            default: self.stateColor = .gray
            }
        }
    }
    
    var name: String? {
        didSet {
            self.nameLabel.text = self.name
        }
    }
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    var stateColor: UIColor? {
        didSet {
            self.imageView.layer.borderColor = self.stateColor?.cgColor
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupImageView()
        self.setupLabel()
    }
    
    private func setupLabel() {
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

