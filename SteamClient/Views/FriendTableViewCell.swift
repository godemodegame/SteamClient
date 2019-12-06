import UIKit

class FriendTableViewCell: UITableViewCell {
    
    public static let reuseIdentifier = "FriendCell"
    
    public var viewModel: User? {
        didSet {
            if let url = self.viewModel?.littleAvatar {
                self.imgView.load(url: url)
            }
            self.namelabel.text = self.viewModel?.name
            self.state = self.viewModel?.state ?? 0
        }
    }
    
    lazy private var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    lazy private var namelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy private var stateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = self.stateColor
        return label
    }()
    
    private var state: Int = 0 {
        didSet {
            switch self.state {
            case 0:
                self.stateLabel.text = "Offline"
                self.stateLabel.textColor = .gray
                self.stateColor = .gray
            case 1:
                self.stateLabel.text = "Online"
                self.stateLabel.textColor = .blue
                self.stateColor = .blue
            case 2:
                self.stateLabel.text = "Busy"
                self.stateLabel.textColor = .red
                self.stateColor = .red
            case 3:
                self.stateColor = .orange
                self.stateLabel.text = "Away"
                self.stateLabel.textColor = .orange
            case 4:
                self.stateColor = .blue
                self.stateLabel.text = "Snooze"
                self.stateLabel.textColor = .blue
            case 5:
                self.stateColor = .blue
                self.stateLabel.text = "Looking to trade"
                self.stateLabel.textColor = .blue
            case 6:
                self.stateColor = .green
                self.stateLabel.text = "Looking to play"
                self.stateLabel.textColor = .green
            default:
                self.stateColor = .gray
                self.stateLabel.textColor = .gray
            }
        }
    }
    
    private var stateColor: UIColor = .gray {
        didSet {
            self.imgView.layer.borderColor = self.stateColor.cgColor
        }
    }
    
    override func layoutSubviews() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.addSubview(self.imgView)
        self.addSubview(self.namelabel)
        self.addSubview(self.stateLabel)
        
        [self.imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         self.imgView.topAnchor.constraint(equalTo: self.topAnchor),
         self.imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0.5),
         self.imgView.widthAnchor.constraint(equalToConstant: 80),
         
         self.namelabel.leadingAnchor.constraint(equalTo: self.imgView.trailingAnchor, constant: 5),
         self.namelabel.topAnchor.constraint(equalTo: self.topAnchor),
         self.namelabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
         
         self.stateLabel.leadingAnchor.constraint(equalTo: self.namelabel.leadingAnchor),
         self.stateLabel.topAnchor.constraint(equalTo: self.namelabel.bottomAnchor, constant: 5)
            ].forEach { $0.isActive = true }
    }
}
