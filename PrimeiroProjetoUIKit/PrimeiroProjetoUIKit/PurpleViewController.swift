//
//  PurpleViewController.swift
//  PrimeiroProjetoUIKit
//
//  Created by Barbara Argolo on 19/10/23.
//

import Foundation
import UIKit
import Hero

class PurpleViewController: UIViewController {
    
    @IBOutlet var purpleView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        purpleView.hero.id = "PurpleViewController"
        
        backButton.layer.cornerRadius = 15
        backButton.clipsToBounds = true
    }
    @IBAction func handleBackButton(_ sender: Any) {
        hero.modalAnimationType = .pageIn(direction: .down)
        hero.dismissViewController()
    }
}

