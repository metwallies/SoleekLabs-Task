//
//  DetailsViewController+CollectionView.swift
//  SoleekLabsTask
//
//  Created by islam metwally on 8/19/19.
//  Copyright © 2019 Islam Metwally. All rights reserved.
//

import UIKit

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        similarProductsCollectionView.delegate = self
        similarProductsCollectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.presenter?.getNumberOfSimilarItems())!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SimilarProductsCollectionViewCell
        
        let tempProduct: Product = (self.presenter?.getProduct(at: indexPath))!
        cell.configureCell(tempProduct, indexPath: indexPath)
        cell.delegate = self.presenter as? similarProductCellDelegate
        
        return cell
    }
}
