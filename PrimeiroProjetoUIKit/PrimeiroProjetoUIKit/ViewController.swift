//
//  ViewController.swift
//  PrimeiroProjetoUIKit
//
//  Created by Barbara Argolo on 01/10/23.
//

import UIKit
import Hero

// Para o primero projeto, usar Swift, UIKit, Storyboard, XIB, ViewCode e uma depêndencia gerenciada pelo Cocoapods. Ter no mínimo tres telas.

class ViewController: UIViewController {
    
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    
    private let descriptionLabel: UILabel = {
         let label = UILabel()
         label.text = "Este app é um exemplo de como usar a biblioteca Hero para melhorar as transições de tela."
         label.textColor = .white 
         label.textAlignment = .center
         label.numberOfLines = 0
         label.font = UIFont.boldSystemFont(ofSize: 24)
         return label
     }()
    
    //configurando em ViewCode
    override func viewDidLoad() {
        super.viewDidLoad()
        //ativando o Hero
        self.hero.isEnabled = true
        
        greenButton.layer.cornerRadius = 15
        greenButton.clipsToBounds = true
        
        purpleButton.layer.cornerRadius = 15
        purpleButton.clipsToBounds = true
        
        view.addSubview(descriptionLabel)

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @IBAction func greenButtonPressed(_ sender: Any) {
        let greenVC = storyboard?.instantiateViewController(withIdentifier: "GreenViewController") as! GreenViewController
        greenVC.hero.modalAnimationType = .zoomSlide(direction: .left)
        present(greenVC, animated: true, completion: nil)
    }
    
    
    @IBAction func purpleButtonPressed(_ sender: Any) {
        let purpleVC = self.storyboard?.instantiateViewController(withIdentifier: "PurpleViewController") as! PurpleViewController
        purpleVC.hero.modalAnimationType = .pageIn(direction: .down)
        present(purpleVC, animated: true, completion: nil)
    }
}
