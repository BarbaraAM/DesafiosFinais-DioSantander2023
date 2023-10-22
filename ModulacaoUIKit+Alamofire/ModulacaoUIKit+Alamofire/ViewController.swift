//
//  ViewController.swift
//  ModulacaoUIKit+Alamofire
//
//  Created by Barbara Argolo on 22/10/23.
//

import UIKit
import Alamofire
import Toast
import TinyConstraints

class ViewController: UIViewController {
    
    struct WeatherResponse: Decodable {
        let temperature: String
        var temperatureValue: Int {
            return Int(temperature) ?? 0
        }
    }
    
    let backgroundImages: [ClosedRange<Int>: String] = [6...20: "light-cloud",
                                                        21...Int.max: "clear",
                                                        -50...5: "snow"]
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 90, weight: .bold)
        return label
    }()
    
    private let chooseCityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Escolha outra cidade", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        let buttonSize = button.intrinsicContentSize
        button.widthAnchor.constraint(equalToConstant: buttonSize.width + 50).isActive = true
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseCityButton.addTarget(self, action: #selector(chooseCityTapped), for: .touchUpInside)
        
        // Fazer uma solicitação usando o Alamofire
        fetchWeatherData(cityName: "São Paulo") // São Paulo por padrão
        
        setupUI()
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(cityNameLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(chooseCityButton)
        
        cityNameLabel.edgesToSuperview(insets: .bottom(450))
        temperatureLabel.edgesToSuperview(insets: .bottom(200))
        
        chooseCityButton.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 30).isActive = true
        chooseCityButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func chooseCityTapped() {
        showCitySelectionAlert()
    }

    private func showCitySelectionAlert() {
        let alertController = UIAlertController(title: "Escolha uma cidade", message: nil, preferredStyle: .actionSheet)
        
        let cities = ["Curitiba", "Manaus", "Rio de Janeiro", "Califórnia", "Londres", "São Paulo", "Alasca"]
        
        for city in cities {
            let action = UIAlertAction(title: city, style: .default) { [weak self] _ in
                self?.fetchWeatherData(cityName: city)
                self?.view.makeToast("Cidade escolhida com sucesso", duration: 4.0, position: .center)
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func fetchWeatherData(cityName: String) {
        AF.request("https://goweather.herokuapp.com/weather/\(cityName)")
            .responseDecodable(of: WeatherResponse.self) { [weak self] response in
                switch response.result {
                case .success(let weatherResponse):
                    self?.cityNameLabel.text = cityName
                    
                    // Tratando a string de temperatura
                    if let temperatureString = weatherResponse.temperature.components(separatedBy: " ").first,
                       let temperature = Int(temperatureString) {
                        self?.temperatureLabel.text = "\(temperature) °C"
                        var selectedImageName: String?
                        for (temperatureRange, imageName) in self!.backgroundImages {
                            if temperatureRange.contains(temperature) {
                                selectedImageName = imageName
                                break
                            }
                        }
                        if let imageName = selectedImageName, let backgroundImage = UIImage(named: imageName) {
                            self?.view.backgroundColor = UIColor(patternImage: backgroundImage)
                        } else {
                            // Imagem padrão
                            let defaultImage = UIImage(named: "light-cloud")
                            self?.view.backgroundColor = UIColor(patternImage: defaultImage!)
                        }
                    } else {
                        self?.temperatureLabel.text = "N/A"
                        let defaultImage = UIImage(named: "light-cloud")
                        self?.view.backgroundColor = UIColor(patternImage: defaultImage!)
                    }
                case .failure(let error):
                    print("Erro em decodar: \(error)")
                }
            }
    }
    
    private func setupUI() {
        // Configurar a interface do usuário inicial
    }
}

//
//#Preview("ViewController") {
//    ViewController()
//}

