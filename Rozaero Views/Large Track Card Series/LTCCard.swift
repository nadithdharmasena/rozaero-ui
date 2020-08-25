//
//  LTCCard.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/10/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class LTCCard: UIView {
    
    var art: CustomImage!
    var info: LTCInfo!
    var rightContainer: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (name: String, artist: String, album: String, artURL:String, text: String = "Currently Playing") {
        super.init(frame: CGRect())
        
        updateInformation(name: name, artist: artist, album: album, artURL: artURL, text: text)
        
    }
    
    func setArt (artURL: String) {
        
        Alamofire.request(artURL).responseImage { response in
            if let image = response.result.value {
                
                self.art = CustomImage(image_data: image, width: Globals.getLTCImageDimensions(), height: Globals.getLTCImageDimensions())
                self.art.frame = CGRect(x: 0, y: 0, width: Globals.getLTCImageDimensions(), height: Globals.getLTCImageDimensions())
                
                self.addSubview(self.art)
                
            }
        }
        
    }
    
    func getHeight () -> CGFloat {
        return max(rightContainer.frame.maxY, Globals.getLTCImageDimensions())
    }
    
    func updateInformation (name: String, artist: String, album: String, artURL: String, text: String) {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        setArt(artURL: artURL)
        
        info = LTCInfo(name: name, artist: artist, album: album, text: text)
        info.frame = CGRect(x: 0, y: 0, width: info.width, height: info.getHeight())
        
        rightContainer = UIView()
        rightContainer.frame = CGRect(x: Globals.getRightContainerXOffset(), y: 0, width: info.width, height: info.getHeight())
        rightContainer.addSubview(info)
        
        self.addSubview(rightContainer)
        
    }

}
