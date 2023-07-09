//
//  HomeViewController+CollectionDelegate.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch HomeSection(rawValue: indexPath.section) {
        case .genres:
            guard let data = (sectionData[.genres] as? [GenreDomain]) else {
                return
            }
            presenter.viewEventSubject.send(.onTapGenre(data[indexPath.row]))
        case .nowPlaying:
            guard let data = (sectionData[.nowPlaying] as? [MovieDiscoverDomain]) else {
                return
            }
            presenter.viewEventSubject.send(.onTapMovie(data[indexPath.row].id))
        case .topRated:
            guard let data = (sectionData[.topRated] as? [MovieDiscoverDomain]) else {
                return
            }
            presenter.viewEventSubject.send(.onTapMovie(data[indexPath.row].id))
        case .upcoming:
            guard let data = (sectionData[.upcoming] as? [MovieDiscoverDomain]) else {
                return
            }
            presenter.viewEventSubject.send(.onTapMovie(data[indexPath.row].id))
        case .popular:
            guard let data = (sectionData[.popular] as? [MovieDiscoverDomain]) else {
                return
            }
            presenter.viewEventSubject.send(.onTapMovie(data[indexPath.row].id))
        case .none:
            return
        }
    }
    
    internal func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            
            guard let sectionType = HomeSection(rawValue: sectionIndex) else {
                fatalError("unknown sectiontype")
            }
            
            switch sectionType {
            case .nowPlaying, .topRated, .upcoming, .popular:
                let sectionLayout = self?.createMoviesSection()
                
                let footerHeaderSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(60.0))
                
                if let header = self?.createSectionHeader(with: footerHeaderSize, type: sectionType) {
                    sectionLayout?.boundarySupplementaryItems = [header]
                }
                
                return sectionLayout
            case .genres:
                return self?.createGenresSection()
            }
            
        }, configuration: config)
        return layout
    }
    
    private func createSectionHeader(with size: NSCollectionLayoutSize, type: HomeSection) -> NSCollectionLayoutBoundarySupplementaryItem {
        switch type {
        case .nowPlaying, .topRated, .upcoming, .popular:
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: size,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            header.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0)
            return header
        default:
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: size,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
            return header
        }
    }
    
    private func createMoviesSection() -> NSCollectionLayoutSection? {
        let screenWidth = screenWidth
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(screenWidth * 0.3), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createGenresSection() -> NSCollectionLayoutSection? {
        let screenWidth = screenWidth
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((screenWidth * 0.3)), heightDimension: .fractionalWidth(0.15))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let section = HomeSection(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
            switch section {
            case .genres:
                return UICollectionReusableView()
            case .nowPlaying, .topRated, .upcoming, .popular:
                let view: SectionHeaderReusableView = collectionView.dequeueReusableView(indexPath: indexPath, kind: kind)
                view.setup(title: section.sectionTitle)
                return view
            }
        default: return UICollectionReusableView()
        }
    }
}

