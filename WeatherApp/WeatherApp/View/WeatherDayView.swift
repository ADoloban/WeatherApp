//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Artem Doloban on 21.12.2023.
//

import UIKit
import SnapKit

class WeatherDayView: UIView {
    let dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.textAlignment = .left
        dayLabel.font = UIFont.boldSystemFont(ofSize: 20)
        dayLabel.textColor = .black
        dayLabel.layer.cornerRadius = 8.0
        dayLabel.clipsToBounds = true
        
        return dayLabel
    }()
    
    let weatherImageView = UIImageView()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.layer.cornerRadius = 8.0
        label.clipsToBounds = true
        
        return label
    }()
    
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.layer.cornerRadius = 8.0
        label.clipsToBounds = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(weather: List) {
        self.init()
        dayLabel.text = weather.weekDay
        weatherImageView.image = weather.weather.first?.description.image
        minTempLabel.text = String(weather.main.tempMin) + "°C"
        maxTempLabel.text = String(weather.main.tempMax) + "°C"
    }
    
    private func setupUI() {
        addSubview(dayLabel)
        addSubview(weatherImageView)
        addSubview(minTempLabel)
        addSubview(maxTempLabel)
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.width.equalToSuperview().multipliedBy(2.5 / 8.0)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.trailing).offset(20)
            make.width.height.equalTo(25)
        }
        
        minTempLabel.snp.makeConstraints { make in
            make.leading.equalTo(weatherImageView.snp.trailing).offset(20)
            make.width.equalToSuperview().multipliedBy(1.75 / 8.0)
            make.centerY.equalToSuperview()
        }
        
        maxTempLabel.snp.makeConstraints { make in
            make.leading.equalTo(minTempLabel.snp.trailing).offset(8)
            make.width.equalToSuperview().multipliedBy(1.75 / 8.0)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
    }
}
