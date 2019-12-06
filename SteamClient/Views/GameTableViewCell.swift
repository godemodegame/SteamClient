import UIKit

class GameTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "OwnGameCell"
    
    public var ownedGameViewModel: OwnedGameViewModel? {
        didSet {
            if let url = self.ownedGameViewModel?.imageUrl {
                self.imgView.load(url: url)
            }
            self.namelabel.text = self.ownedGameViewModel?.name
            self.detaillabel.text = self.ownedGameViewModel?.playedHours
        }
    }
    
    public var recentlyGameViewModel: RecentlyGameViewModel? {
        didSet {
            if let url = self.recentlyGameViewModel?.imageUrl {
                self.imgView.load(url: url)
            }
            self.namelabel.text = self.recentlyGameViewModel?.name
            self.detaillabel.text = self.recentlyGameViewModel?.playedHoursForever
            self.lastTwoWeekslabel.text = self.recentlyGameViewModel?.playedHoursLastTwoWeeks
        }
    }
    
    lazy private var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    lazy private var detaillabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy private var lastTwoWeekslabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override func layoutSubviews() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.addSubview(self.imgView)
        self.addSubview(self.namelabel)
        self.addSubview(self.detaillabel)
        self.addSubview(self.lastTwoWeekslabel)
        [self.imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         self.imgView.topAnchor.constraint(equalTo: self.topAnchor),
         self.imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         self.imgView.widthAnchor.constraint(equalToConstant: 180),
         
         self.namelabel.leadingAnchor.constraint(equalTo: self.imgView.trailingAnchor, constant: 3),
         self.namelabel.topAnchor.constraint(equalTo: self.topAnchor),
         self.namelabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
         
         self.detaillabel.leadingAnchor.constraint(equalTo: self.namelabel.leadingAnchor),
         self.detaillabel.topAnchor.constraint(equalTo: self.namelabel.bottomAnchor),
         
         self.lastTwoWeekslabel.leadingAnchor.constraint(equalTo: self.namelabel.leadingAnchor),
         self.lastTwoWeekslabel.topAnchor.constraint(equalTo: self.detaillabel.bottomAnchor)
            ].forEach { $0.isActive = true }
    }
}
