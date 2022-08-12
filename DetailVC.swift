import UIKit

class DetailVC: UIViewController, FloatingBarDisplaying {
    
    var text: String!
    var hidesFloatingBar: Bool { false }
    
    private var viewModel: CollectionViewModel!
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration.init(appearance: .insetGrouped))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TextCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        configureViews()
        viewModel = CollectionViewModel(collectionView: self.collectionView, initial: Array(0...50).map(String.init))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = text
    }
    
    private func configureViews() {
        self.view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
}

