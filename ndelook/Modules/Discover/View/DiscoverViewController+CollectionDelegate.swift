//
//  DiscoverViewController+CollectionDelegate.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import UIKit

extension DiscoverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = movies[indexPath.row].id
        presenter.viewEventSubject.send(.onTapMovie(id))
    }
    
    internal func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            
            let sectionLayout = self?.createColumnSection(with: 3)
            
            return sectionLayout
            
        }, configuration: config)
        return layout
    }
    
    private func createColumnSection(with column: Int) -> NSCollectionLayoutSection? {
        let itemSizeRatio: Double = (1.0 / Double(column))
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemSizeRatio), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.65))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        return section
    }
}
