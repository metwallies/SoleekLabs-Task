//
//  SimilarProductsCollectionViewCell.swift
//  SoleekLabsTask
//
//  Created by islam metwally on 8/19/19.
//  Copyright © 2019 Islam Metwally. All rights reserved.
//

import UIKit
import Kingfisher

protocol similarProductCellDelegate: class {
    func didAddProduct(at indexPath: IndexPath)
    func didremoveProduct(at indexPath: IndexPath)
}

class SimilarProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var indexPath: IndexPath!
    weak var delegate: similarProductCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.dropShadow()
    }
    @IBAction func addDidTouchUpInside(_ sender: Any) {
        self.delegate?.didAddProduct(at: indexPath)
    }
    @IBAction func removeDidTouchUpInside(_ sender: Any) {
        self.delegate?.didremoveProduct(at: indexPath)
    }
    
    func configureCell(_ product: Product, indexPath: IndexPath) {
        self.productImageView.kf.setImage(with: product.imageURL)
        self.productName.text = product.name
        self.productPriceLabel.text = "\(product.price - product.discountPrice)"
        self.itemCountLabel.text = "\(product.itemCount)"
        
        self.indexPath = indexPath
    }
}
