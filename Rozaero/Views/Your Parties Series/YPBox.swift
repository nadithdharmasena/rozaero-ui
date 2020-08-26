//
//  YPBox.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/13/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class YPBox: UIView {
    
    var box: UIView!
    var text: RParagraph!
    var id: String!
    static var separation: CGFloat = 18
    static var dimensions: CGFloat = (Globals.getContainerWidth() / 2) - YPBox.separation
    static var textOffset: CGFloat = 14

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (name: String, color: UIColor, id: String) {
        super.init(frame: CGRect())
        
        self.id = id
        
        box = UIView()
        box.frame = CGRect(x: 0, y: 0, width: YPBox.dimensions, height: YPBox.dimensions)
        box.backgroundColor = color
        box.layer.cornerRadius = 6
        
        addText(name: name)
        addTapListener()
        
        self.addSubview(box)
        
    }
    
    func addTapListener () {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(YPBox.handlePress))
        self.addGestureRecognizer(tapGesture)
    }
    
    func addText (name: String) {
        let textDimensions = YPBox.dimensions - (YPBox.textOffset * 2)
        
        text = RParagraph(text: name)
        text.frame = CGRect(x: YPBox.textOffset, y: YPBox.textOffset, width: textDimensions, height: textDimensions)
        text.textView.frame = CGRect(x: 0, y: 0, width: text.frame.width, height: text.frame.height)
        
        box.addSubview(text)
    }

    func getDimensions () -> CGFloat {
        return YPBox.dimensions
    }
    
    @objc
    func handlePress (sender: UITapGestureRecognizer) {
        let senderView: YPBox = sender.view as! YPBox
        
        print(senderView.id as String)
    }
    
}
