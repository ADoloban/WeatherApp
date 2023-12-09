//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Anton Pastrevich on 12/4/23.
//

import UIKit
import SnapKit

final class HomePageViewController: UIPageViewController {
    
    private let pageControl = UIPageControl()
    private var pages: [UIViewController] = []
    private var initialPage = 0
    
    //MARK: - GUI Variables
    private lazy var toolBar = UIToolbar()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        configureUI()
    }
    
    // MARK: - Private methods
    @objc
    private func pageControlDidTap(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true)
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
        view.addSubview(toolBar)
        setupConstraints()
        setMocks()
        configurePageControl()
        configureToolbar()
    }
    
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
    
    private func setMocks() {
        let vc1 = WeatherViewController()
        let vc2 = WeatherViewController()
        let vc3 = WeatherViewController()
        pages = [vc1, vc2, vc3]
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
    
    private func setupConstraints() {
        toolBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configurePageControl() {
        pageControl.addTarget(self, action: #selector(pageControlDidTap(_:)), for: .valueChanged)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        pageControl.tintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
    }
    
}

// MARK: - UIPageViewControllerDataSource
extension HomePageViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        return currentIndex == 0 ? pages.last : pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        return currentIndex < pages.count - 1 ? pages[currentIndex + 1] : pages.first
    }
}

// MARK: - UIPageViewControllerDelegate
extension HomePageViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard let viewControllers = pageViewController.viewControllers,
              let currentIndex = pages.firstIndex(of: viewControllers[0]) else {
            return
        }
        pageControl.currentPage = currentIndex
    }
}
