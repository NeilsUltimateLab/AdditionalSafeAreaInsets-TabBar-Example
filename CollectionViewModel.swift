import SwiftUI

class CollectionViewModel: NSObject, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    var items: [String] = []
    var onSelect: ((String, IndexPath)->Void)?
    
    init(collectionView: UICollectionView, initial dataSource: [String]) {
        super.init()
        self.collectionView = collectionView
        self.items = dataSource
        applySnapshot(animated: false)
        collectionView.delegate = self
    }
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, String> = {
        let dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: self.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(TextCell.self, for: indexPath)
            cell?.configure(with: itemIdentifier)
            cell?.backgroundColor = indexPath.item.isMultiple(of: 2) ? .secondarySystemGroupedBackground : .systemBackground
            return cell
        }
        return dataSource
    }()
    
    func applySnapshot(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        self.dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = self.items[safe: indexPath.item] else { return }
        self.onSelect?(item, indexPath)
    }
    
}
