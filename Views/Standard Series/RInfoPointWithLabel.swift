//
//  RInfoPointWithLabel.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/8/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class RInfoPointWithLabel: UIView {
    
    var dataPoint: UILabel!
    var dataLabel: RLabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init (data: String, label: String) {
        super.init(frame: CGRect())
        
        createDataPoint(data: data)
        createDataLabel(label: label)
        
    }
    
    func createDataPoint (data: String) {
        
        dataPoint = UILabel()
        dataPoint.textColor = Globals.textColor
        dataPoint.text = data
        dataPoint.font = UIFont.systemFont(ofSize: Globals.largeTextSize, weight: UIFont.Weight.regular)
        dataPoint.sizeToFit()
        
        self.addSubview(dataPoint)
        
    }
    
    func createDataLabel (label: String) {
        
        dataLabel = RLabel(text: label)
        dataLabel.frame = CGRect(x: 0, y: dataPoint.frame.maxY + 6, width: 0, height: 0)
        dataLabel.sizeToFit()
        
        self.addSubview(dataLabel)
        
    }
    
    func getHeight () -> CGFloat {
        return dataLabel.frame.maxY
    }
    
}
