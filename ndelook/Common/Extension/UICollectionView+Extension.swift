//
//  UICollectionView+Extension.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

extension UICollectionView {
    func dequeCellAtIndexPath<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identity, for: indexPath) as? T else {
            fatalError("cell with \"\(T.identity)\" identifier is not registered!")
        }
        
        return cell
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(indexPath: IndexPath, kind: String) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identity, for: indexPath) as? T else {
            fatalError("reusable view with \"\(T.identity)\" identifier is not registered!")
        }
        
        return cell
    }
}
