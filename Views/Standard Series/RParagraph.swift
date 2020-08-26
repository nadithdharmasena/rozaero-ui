//
//  RParagraph.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/8/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class RParagraph: UIView {
    
    var textView: UITextView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(text: String) {
        super.init(frame: CGRect())
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        
        textView = UITextView()
        textView.frame = CGRect(x: 0, y: 0, width: Globals.getContainerWidth(), height: 0)
        textView.attributedText = attributedString
        textView.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        textView.textColor = Globals.textColor
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isSelectable = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.isScrollEnabled = false
        textView.sizeToFit()
        
        self.addSubview(textView)
        
    }
    
    func getHeight () -> CGFloat {
        return textView.frame.maxY
    }
    
}
