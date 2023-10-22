//
//  ContentView.swift
//  SwiftUI+Combine+SPM
//
//  Created by Barbara Argolo on 21/10/23.
//

import SwiftUI
import AlertToast

struct ContentView: View {
    @ObservedObject var viewModel = TransacoesViewModel()
    @State private var showToastCredito = false
    @State private var showToastDebito = false
    @State private var showToastCancelar = false
    @State private var showToastSalvar = false
    
    var body: some View {
        VStack {
            Text("Saldo: \(viewModel.saldoTexto)")
                .foregroundColor(Double(viewModel.saldoTexto) ?? 0.0 >= 0 ? .green : .red)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            HStack {
                Button("Crédito") {
                    viewModel.operacao = .credito
                    showToastCredito.toggle()
                }
                .buttonStyle(CustomButtonStyle())
                
                Button("Débito") {
                    viewModel.operacao = .debito
                    showToastDebito.toggle()
                }
                .buttonStyle(CustomButtonStyle())
            }
            .padding(.bottom, 20)
            
            if let operacao = viewModel.operacao {
                VStack {
                    Text(operacao == .credito ? "Crédito" : "Débito")
                    
                    TextField("Informe o valor", text: $viewModel.valor)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .padding(.bottom, 10)
                    
                    HStack {
                        Button("Cancelar") {
                            viewModel.operacao = nil
                            viewModel.valor = ""
                            showToastCancelar.toggle()
                        }
                        .buttonStyle(CustomButtonStyle())
                        
                        Button("Salvar") {
                            viewModel.adicionarTransacao()
                            showToastSalvar.toggle()
                        }
                        .buttonStyle(CustomButtonStyle())
                    }
                }
            }
        }
        //AlertToast
        .toast(isPresenting: $showToastCredito, alert: {
            AlertToast(displayMode: .hud, type: .regular, title: "Crédito")
        })
        .toast(isPresenting: $showToastDebito, alert: {
            AlertToast(displayMode: .hud, type: .regular, title: "Débito")
        })
        .toast(isPresenting: $showToastCancelar, alert: {
            AlertToast(type: .error(.red), title: "Ação Cancelada")
        })
        .toast(isPresenting: $showToastSalvar, alert: {
            AlertToast(type: .complete(.blue), title: "Transação Salva")
        })
        
        .padding(20)
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 100, height: 40)
            .background(Color.purple)
            .foregroundColor(.white)
            .font(.system(size: 16))
            .fontWeight(.bold)
            .cornerRadius(15)
    }
}
#Preview {
    ContentView()
}

