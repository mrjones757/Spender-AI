//
//  ViewController.swift
//  Spender-AI
//
//  Created by Stephen Jones on 1/16/23.
//

import UIKit




class ViewController: UIViewController {

    var productService: ProductService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
        let cardView = UIView()
        cardView.frame = CGRect(x: 16, y: 100, width: view.frame.width - 32, height: view.frame.height - 200)
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        view.addSubview(cardView)

        let productImageView = UIImageView()
        productImageView.frame = CGRect(x: 16, y: 16, width: cardView.frame.width - 32, height: cardView.frame.height/2)
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        cardView.addSubview(productImageView)

        let productNameLabel = UILabel()
        productNameLabel.frame = CGRect(x: 16, y: productImageView.frame.maxY + 16, width: cardView.frame.width - 32, height: 20)
        productNameLabel.text = "Product Name"
        productNameLabel.textAlignment = .center
        productNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        cardView.addSubview(productNameLabel)

        let productPriceLabel = UILabel()
        productPriceLabel.frame = CGRect(x: 16, y: productNameLabel.frame.maxY + 8, width: cardView.frame.width - 32, height: 20)
        productPriceLabel.text = "$50"
        productPriceLabel.textAlignment = .center
        productPriceLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cardView.addSubview(productPriceLabel)
        
        productService = ProductService()
        
            }
        }






