//
//  AppCollectionViewCell.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    private var pressedDownTransform =  CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
    
    func addLongPressAnimation(scaledBy: Double = 0.96) {
        self.pressedDownTransform = CGAffineTransform.identity.scaledBy(x: scaledBy, y: scaledBy)
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didTapLongPress))
        longPressRecognizer.minimumPressDuration = 0.05
        longPressRecognizer.cancelsTouchesInView = false
        longPressRecognizer.delegate = self
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
    
    @objc
    private func didTapLongPress(sender: UILongPressGestureRecognizer) {
        
        switch sender.state {
        case .began:
            animate(self, to: pressedDownTransform)
            
        case .changed:
            if self.transform != .identity {
                animate(self, to: .identity)
            }
            
            if self.transform != pressedDownTransform {
                animate(self, to: pressedDownTransform)
            }
        default:
            animate(self, to: .identity)
        }
    }
    
    private func animate(
        _ cell: AppCollectionViewCell,
        to transform: CGAffineTransform
    ) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 3,
            options: [.curveEaseInOut],
            animations: {
                cell.transform = transform
            }, completion: nil
        )
    }
}
