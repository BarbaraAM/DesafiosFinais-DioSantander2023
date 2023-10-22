//
//  SaldoViewModel.swift
//  SwiftUI+Combine+SPM
//
//  Created by Barbara Argolo on 19/10/23.
//
import SwiftUI
import Combine

class TransacoesViewModel: ObservableObject {
    @Published var saldoTexto: String = "0.00"
    @Published var transacoesCredito: [Transacao] = []
    @Published var transacoesDebito: [Transacao] = []
    @Published var operacao: Operacao?
    @Published var valor: String = ""
    
    enum Operacao {
        case credito
        case debito
    }
    
    // Combine Publisher para monitorar alteracoes no saldo
    private var saldoPublisher: AnyPublisher<Double, Never> {
        return $saldoTexto
            .map { Double($0) ?? 0.0 }
            .eraseToAnyPublisher()
    }
    init() {
        //Combine atualiza o saldoTexto
        Publishers.CombineLatest(transacoesCreditoPublisher, transacoesDebitoPublisher)
            .map { (credito, debito) in
                let saldoCredito = credito.reduce(0) { $0 + $1.valor }
                let saldoDebito = debito.reduce(0) { $0 + $1.valor }
                return saldoCredito - saldoDebito
            }
            .map { String(format: "%.2f", $0) }
            .assign(to: &$saldoTexto)
    }
    
    // Combine Publisher para monitorar alteracoes em transacoesCredito
    private var transacoesCreditoPublisher: AnyPublisher<[Transacao], Never> {
        return $transacoesCredito
            .eraseToAnyPublisher()
    }
    
    // Combine Publisher para monitorar alteracoes em transacoesDebito
    private var transacoesDebitoPublisher: AnyPublisher<[Transacao], Never> {
        return $transacoesDebito
            .eraseToAnyPublisher()
    }
    
    func adicionarTransacao() {
        if let valorDouble = Double(valor) {
            let novaTransacao = Transacao(descricao: "Descrição", valor: valorDouble, data: Date(), operacao: operacao ?? .credito)
            if novaTransacao.operacao == .credito {
                transacoesCredito.append(novaTransacao)
                print("Operação Crédito: \(transacoesCredito)")
            } else {
                transacoesDebito.append(novaTransacao)
                print("Operação Débito: \(transacoesDebito)")
            }
            valor = ""
        }
        operacao = nil
    }
}

