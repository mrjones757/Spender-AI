//
//  CustomPageViewController.swift
//  Spender-AI
//
//  Created by Stephen Jones on 1/20/23.
//

import Foundation
import UIKit

class CustomPageViewController: UIPageViewController {

    var currentIndex = 0
    var productService: ProductService!
    var viewControllersArray: [CardViewController] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        productService = ProductService.shared
        productService.loadProducts()

        // Set up the data source and delegate for the UIPageViewController
        dataSource = self
        delegate = self

        // Create an array of view controllers to display
                for i in 0..<productService.products.count {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardViewController") as! CardViewController
                    vc.currentProductIndex = i
                    viewControllersArray.append(vc)
                }
        // Set the initial view controller to display
                setViewControllers([viewControllersArray[currentIndex]], direction: .forward, animated: true, completion: nil)
            }
    

    func setViewControllers(_ viewControllers: [CardViewController], direction: UIPageViewController.NavigationDirection, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        self.viewControllersArray = viewControllers
        super.setViewControllers(viewControllers, direction: direction, animated: animated, completion: completion)
    }

}

// MARK: - UIPageViewControllerDataSource
extension CustomPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllersArray.firstIndex(of: viewController as! CardViewController) else { return nil }
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else { return nil }
        let previousVC = viewControllersArray[previousIndex]
        previousVC.product = productService.products[previousIndex]
        return previousVC
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllersArray.firstIndex(of: viewController as! CardViewController) else { return nil }
        let nextIndex = currentIndex + 1
        guard nextIndex < viewControllersArray.count else { return nil }
        let nextVC = viewControllersArray[nextIndex]
        nextVC.product = productService.products[nextIndex]
        return nextVC
    }

}

// MARK: - UIPageViewControllerDelegate
extension CustomPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentVC = pageViewController.viewControllers?.first as? CardViewController {
            currentIndex = viewControllersArray.firstIndex(of: currentVC) ?? 0
        }
    }
}
