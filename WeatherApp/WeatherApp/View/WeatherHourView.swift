//
//  WeatherHourView.swift
//  WeatherApp
//
//  Created by Artem Doloban on 07.01.2024.
//

import UIKit
import SnapKit

class WeatherHourView: UIView {
    let hourLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.textAlignment = .center
        dayLabel.font = UIFont.boldSystemFont(ofSize: 20)
        dayLabel.textColor = .black
        
        return dayLabel
    }()
    
    let weatherImageView = UIImageView()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init(_ weather: List) {
        self.init(frame: CGRect.zero)
        hourLabel.text = weather.hour
        weatherImageView.image = weather.weather.first?.description.image
        tempLabel.text = String(format: "%.1f", weather.main.temp) + "\u{00B0}"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(hourLabel)
        addSubview(weatherImageView)
        addSubview(tempLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        hourLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(hourLabel.snp.bottom).offset(10)
            make.width.height.equalTo(26)
            make.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(weatherImageView.snp.bottom).offset(10)
        }
    }
}
