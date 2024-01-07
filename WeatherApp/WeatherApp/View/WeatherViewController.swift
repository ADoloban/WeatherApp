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
    private lazy var refreshControl = UIRefreshControl()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.cornerRadius = 10.0
        stackView.spacing = 15
        stackView.clipsToBounds = true
        
        return stackView
    }()
    
    private lazy var cityLabel: UILabel = {
        createUILabel()
    }()
    
    private lazy var tempLabel: UILabel = {
        createUILabel()
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        createUILabel()
    }()
    
    private lazy var humidityLabel: UILabel = {
        createUILabel()
    }()
    
    private func createUILabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 34)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }
    
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
        setupRefreshControl()
    }
    
    private func setupRefreshControl() {
        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(cityLabel)
        scrollView.addSubview(tempLabel)
        scrollView.addSubview(feelsLikeLabel)
        scrollView.addSubview(humidityLabel)
        scrollView.addSubview(stackView)
        setupConstraints()
    }
    
    private func loadWeatherData() {
        refreshControl.beginRefreshing()
        weatherRemoteService.getWeather(for: city) { result in
            DispatchQueue.main.async { [weak self] in
                self?.refreshControl.endRefreshing()
                switch result {
                case .success(let weatherModel):
                    self?.handleDataSuccess(weatherModel: weatherModel)
                case .failure(let error):
                    self?.handleDataError(error: error)
                }
            }
        }
    }
    
    @objc
    private func refreshAction() {
        loadWeatherData()
        refreshControl.endRefreshing()
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
    
    private func handleDataSuccess(weatherModel: WeatherModel) {
        print(weatherModel.list[0].weather.count)
        cityLabel.text = weatherModel.city.name
        let weatherByWeekDay = mapWeatherModelToDailyWeather(from: weatherModel)
        tempLabel.text = String(weatherModel.list.first?.main.temp ?? 0) + " \u{2103}"
        feelsLikeLabel.text = "Feels like: " + String(weatherModel.list.first?.main.feelsLike ?? 0)
        humidityLabel.text = "Humidity: " + String(weatherModel.list.first?.main.humidity ?? 0) + "%"
        updateDaysWeatherStackView(with: weatherByWeekDay)
    }
    
    private func mapWeatherModelToDailyWeather(from weatherModel: WeatherModel) -> [List] {
        var weatherByWeekDay: [List] = []
        for list in weatherModel.list {
            guard !weatherByWeekDay.contains(where: { $0.weekDay == list.weekDay }) else { continue }
            weatherByWeekDay.append(list)
        }
        return weatherByWeekDay
    }
    
    private  func updateDaysWeatherStackView(with weather: [List]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        weather.forEach {
            stackView.addArrangedSubview(WeatherDayView(weather: $0))
        }
    }
}
