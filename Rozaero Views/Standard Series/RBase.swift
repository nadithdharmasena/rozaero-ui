//
//  RBase.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/8/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class RBase: UIView, UITextFieldDelegate {
    
    var scrollView: UIScrollView!
    var mainContainer: UIView!
    var rLogo: RLogo!
    
    var totalWidth: CGFloat!
    var totalHeight: CGFloat!
    
    var containerWidth: CGFloat!
    var containerVerticalOffset: CGFloat!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        totalWidth = Globals.screenDimen.width
        totalHeight = Globals.screenDimen.height
        
        containerWidth = Globals.getContainerWidth()
        containerVerticalOffset = Globals.getContainerVerticalOffset()
        
        self.backgroundColor = Globals.backgroundColor
        self.frame = CGRect(x: 0, y: 0, width: totalWidth, height: totalHeight)
        
        addGestures()
        
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: totalWidth, height: totalHeight)
        
        mainContainer = UIView()
        mainContainer.frame = CGRect(x: 0, y: containerVerticalOffset, width: containerWidth, height: 0)
        
        rLogo = RLogo()
        
        self.addView(view: rLogo, width: Globals.getLogoWidth(), height: Globals.getLogoHeight(), marginTop: 0)
        
        scrollView.addSubview(mainContainer)
        
        self.addSubview(scrollView)
        
    }
    
    func addGestures () {
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RBase.handleTap))
        self.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(RBase.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func addView (view: UIView, width: CGFloat, height: CGFloat, marginTop: CGFloat) {
        
        view.frame = CGRect(x: 0, y: calculateLastSubViewMaxY() + marginTop, width: width, height: height)
        
        self.mainContainer.addSubview(view)
        
    }
    
    func calculateLastSubViewMaxY () -> CGFloat {
        
        if mainContainer.subviews.count > 0 {
            let numberOfSubviews = mainContainer.subviews.count
            let lastSubView: UIView = mainContainer.subviews[numberOfSubviews - 1]
            let calculatedContainerHeight = lastSubView.frame.maxY
            
            return calculatedContainerHeight
        }
        
        return 0
        
    }
    
    func resizeScreen () {
        
        let calculatedContainerHeight = calculateLastSubViewMaxY()
        
        mainContainer.frame = CGRect(x: 0, y: containerVerticalOffset, width: containerWidth, height: calculatedContainerHeight)
        mainContainer.center.x = scrollView.center.x
        
        scrollView.contentSize = CGSize(width: containerWidth, height: calculatedContainerHeight + (2*containerVerticalOffset) )
        
    }

}

// Keyboard related activities
extension RBase {
    
    @objc
    func handleTap (sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    @objc
    func keyboardWillHide (notification: NSNotification) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    // For pressing return on the keyboard to dismiss keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let maxY = textField.superview?.frame.maxY
        let threshold = Globals.screenDimen.height * 0.38
        
        if maxY! > threshold {
            let difference = maxY! - threshold
            scrollView.setContentOffset(CGPoint(x: 0, y: difference), animated: true)
        }
        
    }
    
}
