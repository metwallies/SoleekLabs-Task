//
//  DetailsViewController.swift
//  SoleekLabsTask
//
//  Created by islam metwally on 8/19/19.
//  Copyright © 2019 Islam Metwally. All rights reserved.
//

import UIKit
import Kingfisher

protocol DetailsViewControllerProtocol: class {
    var presenter: DetailsPresenterProtocol? { get set }
    
    func didFetchProduct(_ product: Product)
    func didFailFetchProduct(_ error: String)
    func updateCell(at index: IndexPath, product: Product)
    func didAddSimilarProduct(_ index: IndexPath)
}

class DetailsViewController: UIViewController {

    var presenter: DetailsPresenterProtocol?
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var localDescription: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var similarProductsCollectionView: UICollectionView!
    @IBOutlet weak var containerScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPresenter()
        self.presenter?.fetchProductDetails()
    }
    
    func setupPresenter() {
        self.presenter = DetailsPresenter()
        self.presenter?.view = self
    }
    @IBAction func removeItemDidTouchUpInside(_ sender: Any) {
        self.presenter?.product.itemCount -= 1
        self.itemCountLabel.text = "\(self.presenter?.product.itemCount ?? 0)"
    }
    @IBAction func addItemDidTouchUpInside(_ sender: Any) {
        self.presenter?.product.itemCount += 1
        let imageView = UIImageView()
        imageView.image = self.productImageView.image
        imageView.frame = self.productImageView.frame
        imageView.contentMode = self.productImageView.contentMode
        
        var identity = CGAffineTransform.identity
        identity = identity.translatedBy(x: 0, y: self.view.frame.height)
        identity = identity.scaledBy(x: 0.25, y: 0.25)
        
        self.containerScrollView.addSubview(imageView)
        UIView.animate(withDuration: 0.5, animations: {
            imageView.transform = identity
        }) { (completed) in
            if completed {
                imageView.removeFromSuperview()
            }
        }
        self.itemCountLabel.text = "\(self.presenter?.product.itemCount ?? 0)"
    }
    
}

extension DetailsViewController: DetailsViewControllerProtocol {
    func didFetchProduct(_ product: Product) {
        self.productName.text = product.name
        self.productCategory.text = product.category.name + " > " + (product.category.subCategory?.name ?? "")
        self.productPrice.text = "\(product.price - product.discountPrice) LE"
        self.localDescription.text = product.localDescription
        self.productImageView.kf.setImage(with: product.imageURL)
        self.setupCollectionView()
    }
    
    func didFailFetchProduct(_ error: String) {
        let alert = UIAlertController(title: "Alert!", message: error, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let retry = UIAlertAction(title: "Retry", style: .default) { (_) in
            self.presenter?.fetchProductDetails()
        }
        alert.addAction(cancel)
        alert.addAction(retry)
        self.showDetailViewController(alert, sender: self)
    }
    
    func updateCell(at index: IndexPath, product: Product) {
        if let cell = similarProductsCollectionView.cellForItem(at: index) as? SimilarProductsCollectionViewCell {
            cell.configureCell(product, indexPath: index)
        }
    }
    
    func didAddSimilarProduct(_ index: IndexPath) {
        if let cell = self.similarProductsCollectionView.cellForItem(at: index) as? SimilarProductsCollectionViewCell{
            let frame = self.view.convert(cell.frame, from:self.similarProductsCollectionView)
            let imageView = ImageView()
            imageView.frame = frame
            imageView.image = cell.productImageView.image
            
            var identity = CGAffineTransform.identity
            identity = identity.translatedBy(x: 0, y: 150)
            identity = identity.scaledBy(x: 0.25, y: 0.25)
            
            self.view.addSubview(imageView)
            UIView.animate(withDuration: 0.3, animations: {
                imageView.transform = identity
            }) { (completed) in
                if completed {
                    imageView.removeFromSuperview()
                }
            }
        }
    }
}
