import UIKit

class GameTableViewCell: UITableViewCell {
    lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    lazy var detaillabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10)
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
        [self.imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         self.imgView.topAnchor.constraint(equalTo: self.topAnchor),
         self.imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         self.imgView.widthAnchor.constraint(equalToConstant: 250),
         
         self.namelabel.leadingAnchor.constraint(equalTo: self.imgView.trailingAnchor),
         self.namelabel.topAnchor.constraint(equalTo: self.topAnchor),
         self.namelabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),

         self.detaillabel.leadingAnchor.constraint(equalTo: self.namelabel.leadingAnchor),
         self.detaillabel.topAnchor.constraint(equalTo: self.namelabel.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
}
