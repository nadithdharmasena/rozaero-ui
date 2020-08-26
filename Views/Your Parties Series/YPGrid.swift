//
//  YPGrid.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/13/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class YPGrid: UIView {
    
    var home_vc: HomeController!
    
    var yOffset: CGFloat!
    var parties: [YParty]!
    var add: YPAdd!
    var rLine: RLine!
    var rPrompt: RPrompt!
    var logoutPrompt: RPrompt!
    
    static var colors: [UIColor] = [UIColor.init(red: 223/255, green: 86/255, blue: 91/255, alpha: 1), UIColor.init(red: 122/255, green: 116/255, blue: 189/255, alpha: 1), UIColor.init(red: 94/255, green: 154/255, blue: 178/255, alpha: 1)]

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (home_vc: HomeController) {
        super.init(frame: CGRect())
        self.home_vc = home_vc
        parties = [YParty]()
    }
    
    func setYOffset (yOffset: CGFloat) {
        self.yOffset = yOffset
    }
    
    func addBox (party: YParty) {
        parties.append(party)
    }
    
    func generateGrid (username: String) {
        
        addBoxes()
        addSettings(username: username)
        
        self.frame = CGRect(x: 0, y: self.yOffset, width: Globals.getContainerWidth(), height: logoutPrompt.frame.maxY)
        
    }
    
    func getXCoord (index: Int) -> CGFloat {
        
        let xCoordMultiplier:CGFloat = CGFloat(integerLiteral: index % 2)
        let xCoord:CGFloat = xCoordMultiplier * (YPBox.dimensions + YPBox.separation)
        
        return xCoord
        
    }
    
    func getYCoord (index: Int) -> CGFloat {
        
        let yCoordMultiplier: CGFloat = CGFloat(integerLiteral: index / 2)
        let yCoord: CGFloat = yCoordMultiplier * (YPBox.dimensions + YPBox.separation)
        
        return yCoord
    }
    
    func addBoxes () {
        var ypBox: YPBox!
        var xCoord: CGFloat!
        var yCoord: CGFloat!
        var finalIndex: Int = -1
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        for (index, yParty) in parties.enumerated() {
            
            xCoord = getXCoord(index: index)
            yCoord = getYCoord(index: index)
            
            ypBox = YPBox(name: yParty.name, color: YPGrid.colors[index % 3], id: yParty.id)
            ypBox.frame = CGRect(x: xCoord, y: yCoord, width: ypBox.getDimensions(), height: ypBox.getDimensions())
            
            self.addSubview(ypBox)
            
            finalIndex = index
            
        }
        
        finalIndex += 1
        
        add = YPAdd()
        xCoord = getXCoord(index: finalIndex)
        yCoord = getYCoord(index: finalIndex)
        add.frame = CGRect(x: xCoord, y: yCoord, width: add.getDimensions(), height: add.getDimensions())
        
        
        self.addSubview(add)
    }
    
    func addSettings (username: String) {
        rLine = RLine()
        rLine.frame = CGRect(x: 0, y: add.frame.maxY + 35, width: Globals.getContainerWidth(), height: 1)
        
        self.addSubview(rLine)
        
        rPrompt = RPrompt(text: username)
        rPrompt.frame = CGRect(x: 0, y: rLine.frame.maxY + 25, width: Globals.getContainerWidth(), height: rPrompt.getHeight())
        
        self.addSubview(rPrompt)
        
        logoutPrompt = RPrompt(text: "Logout")
        logoutPrompt.frame = CGRect(x: 0, y: rPrompt.frame.maxY + 10, width: Globals.getContainerWidth(), height: logoutPrompt.getHeight())
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(YPGrid.handleLogout))
        logoutPrompt.addGestureRecognizer(tapGesture)
        
        self.addSubview(logoutPrompt)
        
    }

}

extension YPGrid {
    
    @objc
    func handleLogout (sender: UITapGestureRecognizer) {
        
        self.home_vc.handleLogout()
        
    }
    
}
