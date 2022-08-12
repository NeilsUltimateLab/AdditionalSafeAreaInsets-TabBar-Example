//
//  File.swift
//  Floating Cart
//
//  Created by Yashesh on 14/02/22.
//

import UIKit

class HistoryVC: UIViewController, FloatingBarDisplaying {
    
    private var viewModel: CollectionViewModel!
    
    var hidesFloatingBar: Bool {
        true
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration.init(appearance: .insetGrouped))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TextCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        self.viewModel = CollectionViewModel(collectionView: self.collectionView, initial: Array(1...50).map { "History \($0)"})
        viewModel.onSelect = { [weak self] item, indexPath in
            let vc = SettingsDetailVC(nibName: nil, bundle: nil)
            vc.hidesBottomBarWhenPushed = true
            vc.text = item
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func configureViews() {
        self.view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.title = "History"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}


