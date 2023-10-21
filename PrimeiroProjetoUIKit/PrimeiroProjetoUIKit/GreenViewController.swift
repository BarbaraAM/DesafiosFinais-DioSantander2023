//
//  GreenViewController.swift
//  PrimeiroProjetoUIKit
//
//  Created by Barbara Argolo on 21/10/23.
//

import Foundation
import UIKit
import Hero

class GreenViewController: UIViewController {
    
    @IBOutlet var greenView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        greenView.hero.id = "GreenViewController"
        
        
        backButton.layer.cornerRadius = 23
        backButton.clipsToBounds = true
    }
    
    @IBAction func handleBackButton(_ sender: Any) {
        hero.modalAnimationType = .zoomSlide(direction: .left)
        hero.dismissViewController()
    }
}

