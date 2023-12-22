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
    
    private lazy var scrollView = UIScrollView()
    private lazy var refreshControll = UIRefreshControl()
    
    let firstCell = WeatherCell()
    let secondCell = WeatherCell()
    let thirdCell = WeatherCell()
    let fourthCell = WeatherCell()
    let fifthCell = WeatherCell()
    
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layer.borderWidth = 1.0
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.cornerRadius = 10.0
        stackView.spacing = 15
        stackView.clipsToBounds = true
        
        return stackView
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 34)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 34)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 34)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 34)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
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
        refreshControll.beginRefreshing()
        setupUI()
        loadWeatherData()
    }

    private func setupUI() {
        scrollView.refreshControl = refreshControll
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(cityLabel)
        scrollView.addSubview(tempLabel)
        scrollView.addSubview(feelsLikeLabel)
        scrollView.addSubview(humidityLabel)
        scrollView.addSubview(stackView)
        setupConstraints()
        
        refreshControll.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }

    private func loadWeatherData() {
        weatherRemoteService.getWeather(for: city) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let weatherModel):
                    print(weatherModel.list[0].weather.count)
                    self?.cityLabel.text = weatherModel.city.name
                    self?.tempLabel.text = String(weatherModel.list.first?.main.temp ?? 0) + " \u{2103}"
                    self?.feelsLikeLabel.text = "Feels like: " + String(weatherModel.list.first?.main.feelsLike ?? 0)
                    self?.humidityLabel.text = "Humidity: " + String(weatherModel.list.first?.main.humidity ?? 0) + "%"
                    
                    self?.stackView.addArrangedSubview(WeatherCell(day: "Mon",
                                                                   image: weatherModel.list[0].weather[0].description.image,
                                                                   minT: weatherModel.list[0].main.tempMin,
                                                                   maxT: weatherModel.list[0].main.tempMax))
                    
                    self?.stackView.addArrangedSubview(WeatherCell(day: "Tue",
                                                                   image: weatherModel.list[9].weather[0].description.image,
                                                                   minT: weatherModel.list[9].main.tempMin,
                                                                   maxT: weatherModel.list[9].main.tempMax))
                    
                    self?.stackView.addArrangedSubview(WeatherCell(day: "Wed",
                                                                   image: weatherModel.list[17].weather[0].description.image,
                                                                   minT: weatherModel.list[17].main.tempMin,
                                                                   maxT: weatherModel.list[17].main.tempMax))
                    
                    self?.stackView.addArrangedSubview(WeatherCell(day: "Thu",
                                                                   image: weatherModel.list[25].weather[0].description.image,
                                                                   minT: weatherModel.list[25].main.tempMin,
                                                                   maxT: weatherModel.list[25].main.tempMax))
                    
                    self?.stackView.addArrangedSubview(WeatherCell(day: "Fri",
                                                                   image: weatherModel.list[33].weather[0].description.image,
                                                                   minT: weatherModel.list[33].main.tempMin,
                                                                   maxT: weatherModel.list[33].main.tempMax))

                    self?.refreshControll.endRefreshing()
                case .failure(let error):
                    self?.handleDataError(error: error)
                    self?.refreshControll.endRefreshing()
                }
            }
        }
    }
    
    @objc
    private func refreshAction() {
        loadWeatherData()
        refreshControll.endRefreshing()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView.snp.centerX)
            make.top.equalTo(scrollView.snp.top).inset(20)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView.snp.centerX)
            make.top.equalTo(cityLabel.snp.bottom)
        }
        
        feelsLikeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView.snp.centerX)
            make.top.equalTo(tempLabel.snp.bottom)
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView.snp.centerX)
            make.top.equalTo(feelsLikeLabel.snp.bottom)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(16)
            make.width.equalTo(UIScreen.main.bounds.width - 10)
            make.centerX.equalToSuperview()
        }
    }
    
    private func handleDataError(error: WeatherRemoteServiceError) {
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
