//
//  Globals.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/8/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit
import CoreLocation

// Color related variables
class Globals {
    
    static let backgroundColor:UIColor = UIColor.init(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    
    static let rLabelColor:UIColor = UIColor.init(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
    
    static let textColor:UIColor = UIColor.init(red: 219/255, green: 219/255, blue: 217/255, alpha: 1)
    
    static let headerColor:UIColor = UIColor.init(red: 197/255, green: 176/255, blue: 151/255, alpha: 1)
    
    static let buttonColor:UIColor = UIColor.init(red: 45/255, green: 182/255, blue: 125/255, alpha: 1)
    
    static let yellowColor:UIColor = UIColor.init(red: 234/255, green: 177/255, blue: 45/255, alpha: 1)
    
    static let errorRed: UIColor = UIColor.init(red: 223/255, green: 32/255, blue: 91/255, alpha: 1)
    
}

// Explanation Strings
extension Globals {
    
    static let validateEmailMessage = """
    You will be sent an email containing an 8-digit alphanumerical code. The email may take up to fifteen minutes to arrive. Enter the alphanumerical code below. You will then be redirected to the home screen for you to login. Do not exit out of this screen.
    """
    
    static let hostInitialExplanation = """
    Unfortunately, you can only create a party on our desktop app, but here is what you
    need to think about before hosting.
    """
    
    static let selectLocationExplanation = """
    You will be asked to select a location and set an access region around it. The access region will determine where your party is accessible to guests.
    """
    
    static let choosePlaylistExplanation = """
    Choose which of your personal Spotify playlists will be the base list for the party.
    """
    
    static let activatePartyExplanation = """
    You will need to. Activating your party will make it visible in the access region. Until then, only you can see it. You don’t need to know this one until your party starts, but keep it in mind.
    """
    
}

// Form and internet related variables
extension Globals {
    
    static let emailRegExp = "^[A-Za-z0-9_]+@[A-Za-z0-9_]+\\.[A-Za-z0-9]+$"
    static let baseURL = "http://localhost:3000/"
    
    static let databaseError = 105
    static let internalError = 110
    static let usernameError = 115
    static let emailError = 120
    static let inputError = 125
    static let wrongCodeResponse = 130
    static let passwordMismatchError = 145
    static let noUserResponse = 150
    static let wrongPasswordResponse = 155
    static let successResponse = 200
    
}

// Position and size related variables
extension Globals {
    
    static let screenDimen = UIScreen.main.bounds
    
    static let logoDivisor:CGFloat = 3
    static let smallLogoDivisor:CGFloat = 3.25
    
    static let inputHeight:CGFloat = 40
    
    static let inputMarginTop:CGFloat = 50
    static let promptMarginTop:CGFloat = 25
    
    static let smallInputMarginTop:CGFloat = 40
    static let smallPromptMarginTop:CGFloat = 15
    
    static let buttonMarginTop:CGFloat = 60
    static let smallButtonMarginTop:CGFloat = 50
    
    static let registerInputMarginTop:CGFloat = 30
    static let smallRegisterInputMarginTop:CGFloat = 20
    
    static let registerBelowLogoMargin:CGFloat = 40
    static let smallRegisterBelowLogoMargin:CGFloat = 30
    
    static let paragraphBelowHeaderMargin: CGFloat = 20
    
    static let buttonHeight:CGFloat = 45
    static let buttonCornerRadius:CGFloat = 4
    
    static let ttVoteButtonWidthMultiplier:CGFloat = 0.3
    
    static let ttVoteButtonHeight:CGFloat = 30
    
    static let ttDistanceBetweenTextAndVoteButton:CGFloat = 0.05
    
    static let lineHeight:CGFloat = 1
    
    static let largeTextSize:CGFloat = 22
    
    static let ltcImageMultiplier:CGFloat = 0.5
    
    static let rLabelFontSize:CGFloat = 14
    
    static let headerSize:CGFloat = 28
    static let smallHeaderSize:CGFloat = 26
    
    static let miniHeaderSize: CGFloat = 16
    static let miniSmallHeaderSize: CGFloat = 16
    
    static let belowLogoMargin:CGFloat = 45
    static let smallBelowLogoMargin:CGFloat = 35
    
    static let belowParagraphMargin: CGFloat = 40
    static let smallBelowParagraphMargin: CGFloat = 30
    
    static let bigScreens = ["iPhone10,3", "iPhone10,6", "iPhone11,2", "iPhone11,4", "iPhone11,6","iPhone11,8"]
    
}

// Position and size related functions
extension Globals {
    
    static func getBelowParagraphMargin () -> CGFloat {
        return bigScreens.contains(modelIdentifier()) ? belowParagraphMargin : smallBelowParagraphMargin
    }
    
    static func getRightContainerWidth () -> CGFloat {
        return getContainerWidth() - getRightContainerXOffset()
    }
    
    static func getRightContainerXOffset () -> CGFloat {
        return getLTCImageDimensions() + 20
    }
    
    static func getLTCImageDimensions () -> CGFloat {
        return ltcImageMultiplier * Globals.getContainerWidth()
    }
    
    static func getRegisterBelowLogoMargin() -> CGFloat {
        return bigScreens.contains(modelIdentifier()) ? registerBelowLogoMargin : smallRegisterBelowLogoMargin
    }
    
    static func getRegisterInputMarginTop () -> CGFloat {
        return bigScreens.contains(modelIdentifier()) ? registerInputMarginTop : smallRegisterInputMarginTop
    }
    
    static func getBelowLogoMargin () -> CGFloat {
        return bigScreens.contains(modelIdentifier()) ? belowLogoMargin : smallBelowLogoMargin
    }
    
    static func getButtonMarginTop () -> CGFloat {
        return bigScreens.contains(modelIdentifier()) ? buttonMarginTop : smallButtonMarginTop
    }
    
    static func getInputMarginTop () -> CGFloat {
        return bigScreens.contains(modelIdentifier()) ? inputMarginTop : smallInputMarginTop
    }
    
    static func getPromptMarginTop () -> CGFloat {
        return bigScreens.contains(modelIdentifier()) ? promptMarginTop : smallPromptMarginTop
    }
    
    static func getHeaderSize ()  -> CGFloat {
        return bigScreens.contains(modelIdentifier()) ? headerSize : smallHeaderSize
    }
    
    static func getMiniHeaderSize () -> CGFloat {
        return bigScreens.contains(modelIdentifier()) ? miniHeaderSize : miniSmallHeaderSize
    }
    
    static func getContainerWidth () -> CGFloat {
        return screenDimen.width * 0.825
    }
    
    static func getContainerVerticalOffset () -> CGFloat {
        return bigScreens.contains(modelIdentifier()) ? screenDimen.height * 0.1 : screenDimen.height * 0.08
    }
    
    static func getLogoDivisor () -> CGFloat {
        return bigScreens.contains(modelIdentifier()) ? logoDivisor : smallLogoDivisor
    }
    
    static func getLogoWidth () -> CGFloat {
        return (600.0 / getLogoDivisor())
    }
    
    static func getLogoHeight () -> CGFloat {
        return (192.0 / getLogoDivisor())
    }
    
    static func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
}

// Input related functions 
extension Globals {
    
    static func displayAlert (header: String, message: String, whichVC: UIViewController) {
        
        let alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        whichVC.present(alert, animated: true, completion: nil)
        
    }
    
    static func displayWarning (input: RInputWithLabel, message: String) {
        
        let warningColor = Globals.errorRed
        
        let originalText = input.input.id!
        let originalColor = Globals.rLabelColor
        
        input.line.backgroundColor = warningColor.cgColor
        
        input.label.text = message
        input.label.textColor = warningColor
        input.label.sizeToFit()
        
        revert(input: input, originalText: originalText, originalColor: originalColor)
        
    }
    
    static func revert (input: RInputWithLabel, originalText: String, originalColor: UIColor) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            input.line.backgroundColor = originalColor.cgColor
            
            input.label.text = originalText
            input.label.textColor = originalColor
            input.label.sizeToFit()
            
        }
        
    }
    
    static func isEmpty (inputStr: String) -> Bool {
        return inputStr == "" ? true : false
    }
    
}

// Misc.

extension Globals {
    
    static let locationManager = CLLocationManager()
    
    static var window: UIWindow?
    
    static func setRootToHomeController () {
        
    }
    
    static func setRootToLoginController () {}
    
    static func capitalizeFirstLetter (text: String) -> String {
        
        let initial: String = String(text.first!).uppercased()
        let remaining: String = String(text.dropFirst())
        
        return initial + remaining
        
    }
    
}
