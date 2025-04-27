//
//  DetailViewController.swift
//  GaleriaArtistasCuritiba
//
//  Created by user276557 on 4/25/25.
//
//
//  DetailViewController.swift
//  GaleriaArtistasCuritiba
//
//  Created by user on 4/25/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Propriedades
    private let obra: ObraDeArte
    
    // MARK: - Componentes UI
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let obraImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let tituloLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // MARK: - Inicialização
    init(obra: ObraDeArte) {
        self.obra = obra
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupShareButton()
        configureData()
    }
    
    // MARK: - Configuração da UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Detalhes da Obra"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(obraImageView)
        contentView.addSubview(tituloLabel)
        contentView.addSubview(artistaLabel)
        contentView.addSubview(infoStackView)
        
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Obra Image
            obraImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            obraImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            obraImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            obraImageView.heightAnchor.constraint(equalTo: obraImageView.widthAnchor),
            
            // Título
            tituloLabel.topAnchor.constraint(equalTo: obraImageView.bottomAnchor, constant: 20),
            tituloLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tituloLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Artista
            artistaLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 8),
            artistaLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),
            artistaLabel.trailingAnchor.constraint(equalTo: tituloLabel.trailingAnchor),
            
            // Stack de informações
            infoStackView.topAnchor.constraint(equalTo: artistaLabel.bottomAnchor, constant: 20),
            infoStackView.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: tituloLabel.trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        // Insere itens de ano, estilo e descrição
        let anoItem = createInfoItem(title: "Ano", value: "\(obra.ano)")
        let estiloItem = createInfoItem(title: "Estilo", value: obra.estilo)
        let descricaoItem = createInfoItem(title: "Descrição", value: obra.descricao)
        
        infoStackView.addArrangedSubview(anoItem)
        infoStackView.addArrangedSubview(estiloItem)
        infoStackView.addArrangedSubview(descricaoItem)
    }
    
    // MARK: - Métodos Auxiliares
    private func createInfoItem(title: String, value: String) -> UIStackView {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .tertiaryLabel
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 16)
        valueLabel.numberOfLines = 0
        
        sv.addArrangedSubview(titleLabel)
        sv.addArrangedSubview(valueLabel)
        return sv
    }
    
    private func configureData() {
        obraImageView.image = UIImage(named: obra.imagemNome)
        tituloLabel.text = obra.titulo
        artistaLabel.text = obra.artista
    }
    
    // MARK: - Compartilhamento
    private func setupShareButton() {
        let btn = UIBarButtonItem(barButtonSystemItem: .action,
                                  target: self,
                                  action: #selector(shareTapped))
        navigationItem.rightBarButtonItem = btn
    }
    
    @objc private func shareTapped() {
        let texto = """
        Confira a obra "\(obra.titulo)" por \(obra.artista).
        Descubra mais artistas curitibanos!
        """
        let vc = UIActivityViewController(activityItems: [texto], applicationActivities: nil)
        if let pop = vc.popoverPresentationController {
            pop.barButtonItem = navigationItem.rightBarButtonItem
        }
        present(vc, animated: true)
    }
}
