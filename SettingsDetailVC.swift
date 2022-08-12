//
//  File.swift
//  My App
//
//  Created by Neil Jain on 2/12/22.
//

import UIKit

class SettingsDetailVC: UIViewController, FloatingBarDisplaying {
    
    var hidesFloatingBar: Bool { true }
    var text: String!
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
        self.title = text
        configureViews()
        viewModel = CollectionViewModel(collectionView: self.collectionView, initial: Array(50...100).map(String.init))
    }
    
    
    private func configureViews() {
        self.view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
}
