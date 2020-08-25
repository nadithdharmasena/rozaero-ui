//
//  LPContainer.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/19/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class LPContainer: UIView {
    
    var yOffset: CGFloat!
    var parties: [LParty]!
    
    var parentVC: HomeController!
    var currentCard: LPCard!
    var newCard: LPCard!
    
    var currentCardIndex: Int!
    var available: Bool!
    var threshold: CGFloat!
    var direction: Direction!
    var adjustedCenter: CGFloat!
    
    static let defaultScale: CGFloat = 0.8
    static let defaultAlpha: CGFloat = 0.5
    static let defaultAnimationDuration: TimeInterval = 0.5
    static let defaultOffScreenPosition = Globals.getContainerWidth() + (Globals.screenDimen.width - Globals.getContainerWidth()) / 2

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (parent_vc: HomeController) {
        super.init(frame: CGRect())
        
        parentVC = parent_vc
        threshold = Globals.getContainerWidth() * 0.35
        adjustedCenter = (Globals.getContainerWidth() - LPCard.offset) / 2
        
        addGestures()
        
    }
    
    func addGestures () {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(LPContainer.handlePan))
        self.addGestureRecognizer(panGesture)

    }
    
    func getHeight () -> CGFloat {
        let numberOfSubviews = self.subviews.count
        let lastView: UIView = self.subviews[numberOfSubviews - 1]
        
        return lastView.frame.maxY
    }
    
    func setYOffset (yOffset: CGFloat) {
        self.yOffset = yOffset
    }
    
    func addParties (parties: [LParty]) {
        
        self.parties = parties
        addOriginal(party: self.parties.first!)
        
        currentCardIndex = 0
        
    }
    
    func addOriginal (party: LParty) {
        
        currentCard = createCard(fromParty: party, startingX: -LPCard.offset)
        
        self.addSubview(currentCard)
        generateContainer()
        
    }
    
    func addMessage () {
        
        let nothingHere: RLabel = RLabel(text: "Looks like there's nothing going on.")
        
        nothingHere.frame = CGRect(x: 0, y: 0, width: Globals.getContainerWidth(), height: nothingHere.frame.maxY)
        
        self.addSubview(nothingHere)
        generateContainer()
        
    }
    
    private func generateContainer () {
        self.frame = CGRect(x: 0, y: self.yOffset, width: Globals.getContainerWidth(), height: getHeight())
    }
    
    private func createCard (fromParty party: LParty, startingX: CGFloat) -> LPCard {
        
        let card: LPCard = LPCard(name: Globals.capitalizeFirstLetter(text: party.name), host: Globals.capitalizeFirstLetter(text: party.host), id: party.id, parent_vc: parentVC)
        
        card.frame = CGRect(x: startingX, y: 0, width: LPCard.cardWidth, height: card.getHeight())
        
        return card
        
    }

}

// Swipe navigation related activities
extension LPContainer {
    
    func setupTransition () {
        
        if newCard != nil {
            newCard.removeFromSuperview()
        }
        
        if direction == .Right {
            // Get next party in array, next closest party
            
            if currentCardIndex + 1 < parties.count {
                // There is a next closest party to be displayed
                available = true
                
                let newParty = parties[currentCardIndex + 1]
                
                newCard = createCard(fromParty: newParty, startingX: -LPCard.offset)
                
                newCard.transform = CGAffineTransform(scaleX: LPContainer.defaultScale, y: LPContainer.defaultScale)
                newCard.alpha = LPContainer.defaultAlpha
                
                self.insertSubview(newCard, belowSubview: currentCard)
                
            } else {
                // There is no next closest party to display
                available = false
            }
            
        } else {
            // Get previous party in array, closer party
            
            if currentCardIndex - 1 >= 0 {
                // There is a closer party to be displayed
                available = true
                
                let newParty = parties[currentCardIndex - 1]
                
                newCard = createCard(fromParty: newParty, startingX: LPContainer.defaultOffScreenPosition)
                
                self.insertSubview(newCard, aboveSubview: currentCard)
                
            } else {
                // There is not a closer party to be displayed
                available = false
            }
            
        }
        
    }
    
    func performTransition (xTranslation: CGFloat) {
        
        if direction == .Right {
            
            currentCard.center.x = adjustedCenter + xTranslation
            
            if available {
                
                let scale = LPContainer.defaultScale + getScaleMultiplier(xTranslation: xTranslation)
                newCard.transform = CGAffineTransform(scaleX: scale, y: scale)
                
                newCard.alpha = LPContainer.defaultAlpha + getAlphaMultiplier(xTranslation: xTranslation)
                
            }
            
        } else {
            
            if available {
                newCard.center.x = 1.5 * LPContainer.defaultOffScreenPosition + xTranslation
                
            }
            
            let scale = 1 + getScaleMultiplier(xTranslation: xTranslation)
            currentCard.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            currentCard.alpha = 1 + getAlphaMultiplier(xTranslation: xTranslation)
            
        }
        
    }
    
    func endTransition (xTranslation: CGFloat) {
        
        if direction == .Right {
            
            if available && abs(xTranslation) > threshold {
                
                UIView.animate(withDuration: LPContainer.defaultAnimationDuration, animations: {
                    self.currentCard.center.x = 1.5 * LPContainer.defaultOffScreenPosition
                    self.newCard.alpha = 1
                    self.newCard.transform = CGAffineTransform(scaleX: 1, y: 1)
                }) { result in
                    self.postFullAnimationOperations()
                    self.currentCardIndex += 1
                }
                
            } else {
                
                UIView.animate(withDuration: LPContainer.defaultAnimationDuration, animations: {
                    self.currentCard.center.x = self.adjustedCenter
                    
                    if self.available {
                        self.newCard.transform = CGAffineTransform(scaleX: LPContainer.defaultScale, y: LPContainer.defaultScale)
                        self.newCard.alpha = LPContainer.defaultAlpha
                    }
                    
                }) { result in
                    self.postPartialAnimationOperations()
                }
                
            }
        } else {
            
            if available && abs(xTranslation) > threshold {
                
                UIView.animate(withDuration: LPContainer.defaultAnimationDuration, animations: {
                    self.currentCard.transform = CGAffineTransform(scaleX: LPContainer.defaultScale, y: LPContainer.defaultScale)
                    self.currentCard.alpha = LPContainer.defaultAlpha
                    
                    self.newCard.center.x = self.adjustedCenter
                    
                }) { result in
                    
                    self.postFullAnimationOperations()
                    self.currentCardIndex -= 1
                    
                }
                
            } else {
                
                UIView.animate(withDuration: LPContainer.defaultAnimationDuration, animations: {
                    
                    self.currentCard.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.currentCard.alpha = 1
                    
                    if self.available {
                        self.newCard.center.x = 1.5 * LPContainer.defaultOffScreenPosition
                    }
                    
                    
                }) { result in
                    self.postPartialAnimationOperations()
                }
                
            }
            
        }
        
    }
    
    func postFullAnimationOperations () {
        
        self.currentCard.removeFromSuperview()
        
        self.currentCard = self.newCard
        self.available = false
        self.newCard = nil
        self.direction = nil
        
    }
    
    func postPartialAnimationOperations () {
        self.direction = nil
        self.available = false
    }
    
    func getAlphaMultiplier (xTranslation: CGFloat) -> CGFloat {
        return (xTranslation / Globals.getContainerWidth()) * 0.3
    }
    
    func getScaleMultiplier (xTranslation: CGFloat) -> CGFloat {
        return (xTranslation / Globals.getContainerWidth()) * (1 - LPContainer.defaultScale)
    }
    
    func determineDirection (xTranslation: CGFloat) {
        
        if xTranslation > 0 {
            direction = .Right
        } else if xTranslation <= 0 {
            direction = .Left
        }
        
    }
    
    func didDirectionChange (previous: Direction?) -> Bool {
        
        if previous == direction {
            return false
        }
        
        return true
        
    }
    
}

// Gesture related activities
extension LPContainer {
    
    @objc
    func handlePan (sender: UIPanGestureRecognizer) {
        
        let xTranslation = sender.translation(in: self).x
        
        let previousDirection = direction
        determineDirection(xTranslation: xTranslation)
        
        if didDirectionChange(previous: previousDirection) {
            // Stop everything you were doing before and do the opposite
            setupTransition()
            
        } else {
            // Keep doing whatever you were doing before
            performTransition(xTranslation: xTranslation)
            
        }
        
        
        if sender.state == .ended {
            endTransition(xTranslation: xTranslation)
            
        }
        
    }
    
}


enum Direction {
    case Right
    case Left
}
