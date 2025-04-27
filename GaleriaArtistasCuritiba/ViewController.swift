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
    private var searchBar: UISearchBar!
    private var filteredObras: [ObraDeArte] = []
    private var isFiltering: Bool {
        return !(searchBar.text?.isEmpty ?? true)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        setupSearchBar()
        filteredObras = obras
    }
    
    
    // MARK: - Setup
    private func setupNavigationBar() {
        title = "Artistas Curitibanos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - ScrollView Delegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()  // Esconde o teclado ao rolar
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Buscar por título ou artista"
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
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
        return isFiltering ? filteredObras.count : obras.count //usa a lista filtrada
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ObraCollectionViewCell.identifier,
            for: indexPath
        ) as? ObraCollectionViewCell else {
            fatalError("Failed to dequeue ObraCollectionViewCell")
        }

        let obra = isFiltering ? filteredObras[indexPath.row] : obras[indexPath.row]
        cell.configure(with: obra)
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isLandscape = traitCollection.verticalSizeClass == .compact
        let availableWidth = view.frame.width - 48
        let numberOfColumns: CGFloat = isLandscape ? 4 : (view.frame.width > 600 ? 3 : 2) // 4 colunas no modo paisagem
        let cellWidth = (availableWidth / numberOfColumns).rounded(.down)
        return CGSize(width: cellWidth, height: cellWidth + 60)
    }


    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.1, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) // Reduz tamanho
            }) { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    cell.transform = CGAffineTransform.identity // Restaura tamanho original
                }) { _ in
                    // Navegação após a animação
                    let obraSelecionada = self.obras[indexPath.item]
                    let detalheVC = DetailViewController(obra: obraSelecionada)
                    self.navigationController?.pushViewController(detalheVC, animated: true)
                }
            }
        }
    }
    

}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredObras = obras
        } else {
            filteredObras = obras.filter { obra in
                obra.titulo.lowercased().contains(searchText.lowercased()) ||
                obra.artista.lowercased().contains(searchText.lowercased())
            }
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filteredObras = obras
        searchBar.resignFirstResponder()
        collectionView.reloadData()
    }
}
