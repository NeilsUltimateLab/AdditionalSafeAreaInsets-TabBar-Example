import UIKit
import AppUtilities

class HomeVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration.init(appearance: .insetGrouped))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TextCell.self)
        return collectionView
    }()
    
    private var viewModel: CollectionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        viewModel = CollectionViewModel(collectionView: self.collectionView, initial: (0...20).map{"Home \($0 + 1)"})
        viewModel.onSelect = { [weak self] item, indexPath in
            let vc = DetailVC(nibName: nil, bundle: nil)
            vc.text = item
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func configureViews() {
        self.view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.title = "Home"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

