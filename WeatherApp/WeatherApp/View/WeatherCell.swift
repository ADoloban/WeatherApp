//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Artem Doloban on 21.12.2023.
//

import UIKit
import SnapKit

class WeatherCell: UITableViewCell {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    convenience init (day: String, image: UIImage?, minT: Double?, maxT: Double?) {
        self.init()
        dayLabel.text = day
        weatherImageView.image = image ?? UIImage()
        minTempLabel.text = String(minT ?? 0) + "°C"
        maxTempLabel.text = String(maxT ?? 0) + "°C"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            make.width.equalToSuperview().multipliedBy(2.0 / 8.0)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25)
            
        }
        
        minTempLabel.snp.makeConstraints { make in
            make.leading.equalTo(weatherImageView.snp.trailing).offset(20)
            make.width.equalToSuperview().multipliedBy(2.0 / 8.0)
            make.centerY.equalToSuperview()
        }
        
        maxTempLabel.snp.makeConstraints { make in
            make.leading.equalTo(minTempLabel.snp.trailing).offset(8)
            make.width.equalToSuperview().multipliedBy(2.0 / 8.0)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
    }
}
