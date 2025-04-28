	//
//  DataManager.swift
//  GaleriaArtistasCuritiba
//
//  Created by user276557 on 4/25/25.
//

// DataManager.swift
import UIKit

final class DataManager {
    static let obras: [ObraDeArte] = [
        ObraDeArte(
            titulo: "Cortiço",
            artista: "Poty Lazzarotto",
            ano: 1950,
            estilo: "Modernismo",
            imagemNome: "Obra1",
            descricao: "Poty Lazzarotto foi um renomado muralista curitibano, conhecido por suas obras que retratam a cultura e o cotidiano urbano."
        ),
        ObraDeArte(
            titulo: "Vento Sul",
            artista: "Fernando Velloso",
            ano: 1985,
            estilo: "Abstrato",
            imagemNome: "Obra2",
            descricao: "Velloso é um dos pioneiros da arte abstrata no Paraná, com influências do expressionismo."
        ),
        ObraDeArte(
            titulo: "Cidade Sorriso",
            artista: "Maria Lucia Martins",
            ano: 2003,
            estilo: "Contemporâneo",
            imagemNome: "Obra3",
            descricao: "Maria Lucia explora a relação entre arquitetura e emoções em suas instalações urbanas."
        ),
        ObraDeArte(
            titulo: "Raízes",
            artista: "Eliane Prolik",
            ano: 2012,
            estilo: "Escultura",
            imagemNome: "Obra4",
            descricao: "Escultura em metal que representa a conexão entre a natureza e a industrialização em Curitiba."
        )
    ]
}
