import UIKit

class CartFloatingView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 21)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    
    private func configureViews() {
        self.backgroundColor = .systemGreen
        
        self.layer.cornerRadius = 8
        self.layer.cornerCurve = .continuous
        self.layer.masksToBounds = true
        
        self.addSubview(titleLabel)
        self.addSubview(countLabel)
        self.addSubview(descriptionLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: 8).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    }
    
    func configure(title: String, description: String, count: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.countLabel.text = count
    }
    
}

