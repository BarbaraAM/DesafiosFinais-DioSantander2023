//
//  TransacaoModel.swift
//  SwiftUI+Combine+SPM
//
//  Created by Barbara Argolo on 21/10/23.
//

import Foundation

struct Transacao {
    var descricao: String
    var valor: Double
    var data: Date
    var operacao: TransacoesViewModel.Operacao
}



