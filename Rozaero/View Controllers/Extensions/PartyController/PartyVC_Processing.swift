//
//  PartyVC_Processing.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/27/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

// API Data Processing activities
extension PartyViewController {
    
    func displayCurrentTrack () {
        
        let current_track: Dictionary<String, Any> = self.party_info["current"] as! Dictionary<String, Any>
        
        let album_info: Dictionary<String, Any> = current_track["album"] as! Dictionary<String, Any>
        let album_art_info = album_info["image"] as! Dictionary<String, Any>
        
        let artist_array: NSArray = current_track["artist"] as! NSArray
        let artist_info: Dictionary<String, Any> = artist_array[0] as! Dictionary<String, Any>
        
        let track_info: Dictionary<String, Any> = current_track["track"] as! Dictionary<String, Any>
        
        let name: String = track_info["name"] as! String
        let artist: String = artist_info["name"] as! String
        let album: String = album_info["name"] as! String
        let artURL: String = album_art_info["url"] as! String
        
        let current_card: LTCCard = LTCCard(name: name, artist: artist, album: album, artURL: artURL)
        
        self.rBase.addView(view: current_card, width: current_card.frame.width, height: current_card.getHeight(), marginTop: Globals.getBelowLogoMargin())
        
    }
    
    func displayTracks () {
        
        for element in self.tracks_data {
            
            let track_info: Dictionary<String, Any> = element["track"] as! Dictionary<String, Any>
            let party_info: Dictionary<String, Any> = element[self.id] as! Dictionary<String, Any>
            
            let artist_array: NSArray = element["artist"] as! NSArray
            let artist_info: Dictionary<String, Any> = artist_array[0] as! Dictionary<String, Any>
            
            let track_name = track_info["name"] as! String
            let track_id = track_info["id"] as! String
            let artist_name = artist_info["name"] as! String
            let num_votes = party_info["votes"] as! Int
            
            let new_card: TTCard = TTCard(name: track_name, artist: artist_name, trackID: track_id, numVotes: num_votes, partyVC: self)
            
            self.rBase.addView(view: new_card, width: Globals.getContainerWidth(), height: new_card.getHeight(), marginTop: Globals.getBelowParagraphMargin())
        
        }
        
    }
    
    func displayPartyInfo () {
        
        let name: String = self.party_info["name"] as! String
        let host: String = self.party_info["host"] as! String
        
        let name_card: RHTextWithLabel = RHTextWithLabel(text: name, label: "Party Name")
        let host_card: RHTextWithLabel = RHTextWithLabel(text: host, label: "Party Host")
        
        name_card.header.font = UIFont.systemFont(ofSize: Globals.getHeaderSize() - 3, weight: UIFont.Weight.bold)
        host_card.header.font = UIFont.systemFont(ofSize: Globals.getHeaderSize() - 3, weight: UIFont.Weight.bold)
        
        name_card.header.textColor = Globals.textColor
        host_card.header.textColor = Globals.textColor
        
        self.rBase.addView(view: name_card, width: name_card.frame.width, height: name_card.getHeight(), marginTop: Globals.getBelowLogoMargin() - 4)
        
        self.rBase.addView(view: host_card, width: host_card.frame.width, height: host_card.getHeight(), marginTop: Globals.getBelowLogoMargin() - 4)
        
        let spacer: RLine = RLine()
        spacer.line.backgroundColor = UIColor.clear
        
        self.rBase.addView(view: spacer, width: spacer.frame.width, height: 1, marginTop: Globals.getBelowLogoMargin())
        
    }
    
    
}

