//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Anton Pastrevich on 12/4/23.
//

import UIKit

final class WeatherViewController: UIViewController {
    let city: String

    private let weatherRemoteService = WeatherRemoteService()

    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.textAlignment = .center
        cityLabel.font = .systemFont(ofSize: 34)
        cityLabel.textColor = .black
        cityLabel.numberOfLines = 0
        
        return cityLabel
    }()

    init(city: String) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadWeatherData()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(cityLabel)

        setupConstraints()
    }

    private func loadWeatherData() {
        weatherRemoteService.getWeather(for: city) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let weatherModel):
                    print("data is loaded")
                    print(weatherModel.list[0].main.tempMax)
                    
                case .failure(let error):
                    let alertController = UIAlertController(title: "Error",
                                                            message: error.description,
                                                            preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK",
                                                 style: .destructive,
                                                 handler: nil)
                    alertController.addAction(okAction)
                    present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func setupConstraints() {
        cityLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
}
