//
//  AppButton.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

class AppButton: UIButton, UIGestureRecognizerDelegate {
    var textStyle: AppTextStyle = .textButton {
        didSet {
            applyStyle()
        }
    }
    
    var textAttributesCallback: (() -> AppTextAttributes?)?
    private var originalBackgroundColor: UIColor?
    private var longPressGestureRecognizer: UILongPressGestureRecognizer!
    
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    var padding: UIEdgeInsets = .zero {
        didSet {
            contentEdgeInsets = padding
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle()
        setupLongPressGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyStyle()
        setupLongPressGesture()
    }
    
    convenience init(textStyle: AppTextStyle, textAttributesCallback: (() -> AppTextAttributes?)? = nil) {
        self.init(frame: .zero)
        self.textStyle = textStyle
        self.textAttributesCallback = textAttributesCallback
    }
    
    override var titleLabel: UILabel? {
        return super.titleLabel
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        applyStyle()
    }
    
    private func applyStyle() {
        let textAttributes = textAttributesCallback?() ?? AppTextAttributes()
        let attributes = AppTheme.textStyle(forType: textStyle, attributes: textAttributes)
        
        setAttributedTitle(NSAttributedString(string: title(for: .normal) ?? "", attributes: attributes), for: .normal)
        
        originalBackgroundColor = AppTheme.primaryColor
        backgroundColor = originalBackgroundColor
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        
        contentEdgeInsets = padding
    }
    
    private func setupPressedEffect() {
        addTarget(self, action: #selector(applyPressedEffect), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(removePressedEffect), for: [.touchUpInside, .touchUpOutside, .touchDragExit, .touchCancel])
    }
    
    private func setupLongPressGesture() {
        addLongPressAnimation()
    }
    
    @objc private func applyPressedEffect() {
        backgroundColor = originalBackgroundColor?.darker(by: 20)
    }
    
    @objc private func removePressedEffect() {
        backgroundColor = originalBackgroundColor
    }
    
    private var pressedDownTransform =  CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
    
    private func addLongPressAnimation(scaledBy: Double = 0.96) {
        self.pressedDownTransform = CGAffineTransform.identity.scaledBy(x: scaledBy, y: scaledBy)
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didTapLongPress))
        longPressRecognizer.minimumPressDuration = 0.05
        longPressRecognizer.cancelsTouchesInView = false
        longPressRecognizer.delegate = self
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc
    private func didTapLongPress(sender: UILongPressGestureRecognizer) {
        
        switch sender.state {
        case .began:
            animate(self, to: pressedDownTransform)
            backgroundColor = originalBackgroundColor?.darker(by: 20)
            
        case .changed:
            if self.transform != .identity {
                animate(self, to: .identity)
                backgroundColor = originalBackgroundColor
            }
            
            if self.transform != pressedDownTransform {
                animate(self, to: pressedDownTransform)
                backgroundColor = originalBackgroundColor?.darker(by: 20)
            }
        default:
            animate(self, to: .identity)
            backgroundColor = originalBackgroundColor
        }
    }
    
    private func animate(_ view: UIView, to transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
            view.transform = transform
        }, completion: nil)
    }
}
