//
//  DiscoverViewController+CollevtionDataSource.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import UIKit

extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieViewCell = collectionView.dequeCellAtIndexPath(indexPath: indexPath)
        cell.setupMovie(movies[indexPath.row])
        return cell
    }
    
}
