//  ViewController.swift
//  GaleriaArtistasCuritiba
//
//  Created by user276557 on 4/24/25.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private var collectionView: UICollectionView!
    private let obras = DataManager.obras
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
    }
    
    // MARK: - Setup
    private func setupNavigationBar() {
        title = "Artistas Curitibanos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ObraCollectionViewCell.self,
                                forCellWithReuseIdentifier: ObraCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(collectionView)
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        obras.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ObraCollectionViewCell.identifier,
            for: indexPath
        ) as? ObraCollectionViewCell else {
            fatalError("Failed to dequeue ObraCollectionViewCell")
        }
        
        cell.configure(with: obras[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 48) / 2  // 2 colunas com espaçamento
        return CGSize(width: width, height: width + 60)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let obraSelecionada = obras[indexPath.item]
        let detalheVC = DetailViewController(obra: obraSelecionada)
        navigationController?.pushViewController(detalheVC, animated: true)
    }
}
