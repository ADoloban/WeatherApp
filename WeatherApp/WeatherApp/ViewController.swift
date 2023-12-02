//
//  ViewController.swift
//  WeatherApp
//
//  Created by Artem Doloban on 02.12.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: - GUI Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "WEATHER"
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        
        toolbar.backgroundColor = .red
        
        return toolbar
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.tintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        
        return pageControl
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureToolbar()
    }

    //MARK: - Private methods
    private func configureToolbar() {
        let mapButton = UIBarButtonItem(image: UIImage(systemName: "map"),
                                        style: .done,
                                        target: self,
                                        action: #selector(mapButtonAction))
        
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"),
                                         style: .done,
                                         target: self,
                                         action: #selector(listButtonAction))
        
        let pageControl = UIBarButtonItem(customView: pageControl)
        
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        
        toolBar.setItems([mapButton, flexibleSpace, pageControl, flexibleSpace, listButton], animated: true)
    }
    
    @objc
    private func mapButtonAction() {
        print("map action")
    }
    
    @objc
    private func listButtonAction() {
        print("list action")
    }
    
    private func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(toolBar)
        
        view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(100)
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(50)
        }
        
        toolBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

