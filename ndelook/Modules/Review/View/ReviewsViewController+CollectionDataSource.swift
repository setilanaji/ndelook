//
//  ReviewsViewController+CollectionDataSource.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import UIKit

extension ReviewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ReviewViewCell = collectionView.dequeCellAtIndexPath(indexPath: indexPath)
        cell.setup(review: reviews[indexPath.row])
        return cell
    }
}
