import UIKit

class FriendTableViewCell: UITableViewCell {
    lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    lazy var namelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
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
        
        [self.imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         self.imgView.topAnchor.constraint(equalTo: self.topAnchor),
         self.imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0.5),
         self.imgView.widthAnchor.constraint(equalToConstant: 80),
         
         self.namelabel.leadingAnchor.constraint(equalTo: self.imgView.trailingAnchor, constant: 5),
         self.namelabel.topAnchor.constraint(equalTo: self.topAnchor),
         self.namelabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
        ].forEach { $0.isActive = true }
    }
}
