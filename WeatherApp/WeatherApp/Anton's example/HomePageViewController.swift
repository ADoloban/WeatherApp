//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Anton Pastrevich on 12/4/23.
//

import UIKit
import SnapKit

// HomePageViewController Will work as a container for your cities  WetherViewControllers

// TODO: - You have to:
// 1. Learn how UIPageViewController works
// 2. Add toolbar what you have in the ViewController to this HomePageViewController
final class HomePageViewController: UIPageViewController {
    private let pageControl = UIPageControl()
    private var pages: [UIViewController] = []
    private var initialPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        // Setup PageControll
        pageControl.addTarget(self, action: #selector(pageControlDidTap(_:)), for: .valueChanged)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        pageControl.tintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        // setup test ViewControllers to represent Weathers Pages
        let vc1 = WeatherViewController()
        let vc2 = WeatherViewController()
        let vc3 = WeatherViewController()
        vc1.titleText = "Poznan"
        vc2.titleText = "Prague"
        vc3.titleText = "Berlin"
        pages = [vc1, vc2, vc3]
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }

    @objc
    private func pageControlDidTap(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true)
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
