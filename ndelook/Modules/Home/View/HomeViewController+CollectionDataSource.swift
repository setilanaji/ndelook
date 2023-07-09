//
//  HomeViewController+CollectionDataSource.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch HomeSection(rawValue: section) {
        case .genres:
            return (sectionData[.genres] as? [GenreDomain])?.count ?? 0
        case .nowPlaying:
            return (sectionData[.nowPlaying] as? [MovieDiscoverDomain])?.count ?? 0
        case .topRated:
            return (sectionData[.topRated] as? [MovieDiscoverDomain])?.count ?? 0
        case .upcoming:
            return (sectionData[.upcoming] as? [MovieDiscoverDomain])?.count ?? 0
        case .popular:
            return (sectionData[.popular] as? [MovieDiscoverDomain])?.count ?? 0
        case .none:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch HomeSection(rawValue: indexPath.section) {
        case .genres:
            let cell: GenreViewCell = collectionView.dequeCellAtIndexPath(indexPath: indexPath)
            guard let data = (sectionData[.genres] as? [GenreDomain]) else {
                return UICollectionViewCell()
            }
            cell.setup(genre: data[indexPath.row])
            return cell
        case .nowPlaying:
            let cell: MovieViewCell = collectionView.dequeCellAtIndexPath(indexPath: indexPath)
            guard let data = (sectionData[.nowPlaying] as? [MovieDiscoverDomain]) else {
                return UICollectionViewCell()
            }
            cell.setupMovie(data[indexPath.row])
            return cell
        case .topRated:
            let cell: MovieViewCell = collectionView.dequeCellAtIndexPath(indexPath: indexPath)
            guard let data = (sectionData[.topRated] as? [MovieDiscoverDomain]) else {
                return UICollectionViewCell()
            }
            cell.setupMovie(data[indexPath.row])
            return cell
        case .upcoming:
            let cell: MovieViewCell = collectionView.dequeCellAtIndexPath(indexPath: indexPath)
            guard let data = (sectionData[.upcoming] as? [MovieDiscoverDomain]) else {
                return UICollectionViewCell()
            }
            cell.setupMovie(data[indexPath.row])
            return cell
        case .popular:
            let cell: MovieViewCell = collectionView.dequeCellAtIndexPath(indexPath: indexPath)
            guard let data = (sectionData[.popular] as? [MovieDiscoverDomain]) else {
                return UICollectionViewCell()
            }
            cell.setupMovie(data[indexPath.row])
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
}
