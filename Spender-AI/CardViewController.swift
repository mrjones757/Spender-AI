//
//  CardViewController.swift
//  Spender-AI
//
//  Created by Stephen Jones on 1/18/23.
//

import Foundation
import UIKit
import Kingfisher



class CardViewController: UIViewController {
    var productService = ProductService.shared
    var product: Product!
    @IBOutlet var cardView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productView: UIView!
    
    var currentProductIndex = 0
    var cardInitialCenter: CGPoint!
    var cardInitialTransform: CGAffineTransform!
    var CPVController = CustomPageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the product service
        productService = ProductService.shared
        
        // Load the products from json file
        productService.loadProducts()
        
        cardInitialCenter = cardView.center
        cardInitialTransform = cardView.transform
        
        // Add vignette to the bottom of the image view
        let gradient = CAGradientLayer()
        gradient.frame = productImageView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1.0]
        productImageView.layer.insertSublayer(gradient, at: 0)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight))
        swipeRight.direction = .right
        productView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
        swipeLeft.direction = .left
        productView.addGestureRecognizer(swipeLeft)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !productService.products.isEmpty, currentProductIndex < productService.products.count else {
            print("Error: Product array is empty or index is out of bounds")
            return
        }
        updateProductInformation()
    }
    
    @objc func didSwipeLeft() {
        guard let currentVC = CPVController.viewControllers?.first as? CardViewController,
              let currentIndex = CPVController.viewControllersArray.firstIndex(of: currentVC) else { return }
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else { return }
        let previousVC = CPVController.viewControllersArray[previousIndex]
        previousVC.product = productService.products[previousIndex]
        CPVController.setViewControllers([previousVC], direction: .reverse, animated: true, completion: nil)
    }


    @objc func didSwipeRight() {
        guard let currentVC = CPVController.viewControllers?.first as? CardViewController,
              let currentIndex = CPVController.viewControllersArray.firstIndex(of: currentVC) else { return }
        let nextIndex = currentIndex + 1
        guard nextIndex < CPVController.viewControllersArray.count else { return }
        let nextVC = CPVController.viewControllersArray[nextIndex]
        nextVC.product = productService.products[nextIndex]
        CPVController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
    }



    
    func updateProductInformation() {
            let product = productService.products[currentProductIndex]
            productNameLabel.text = product.name
            productPriceLabel.text = product.price
            if let imageUrl = URL(string: product.imageUrl) {
                productImageView.kf.setImage(with: imageUrl)
            }
        }
}
