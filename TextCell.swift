import UIKit

class TextCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        self.contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func configure(with title: String) {
        self.titleLabel.text = title
    }
}

