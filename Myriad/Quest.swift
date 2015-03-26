//
//  Quest.swift
//  Myriad
//
//  Created by Anthony Smith on 3/21/15.
//  Copyright (c) 2015 Anthony Smith. All rights reserved.
//

import Foundation

class Quest {
    //Quest Data
    var questId : String
    var questName : String
    var questImgURL : String
    var questDesription : String
    var questGiverID : String
    var questGiverName : String
    var questGiverImg : String
    
    //Giver Data
    /*var giverId : Int
    var giverName : String
    var giverImgURL : String*/
    
    init (initQuestId : String , initQuestName : String, initQuestImgURL : String, initQuestDescription : String, initQuestGiverID : String, initQuestGiverName : String, initQuestGiverImg : String)
    {
        questId = initQuestId
        questName = initQuestName
        questImgURL = initQuestImgURL
        questDesription = initQuestDescription
        
        questGiverID = initQuestGiverID
        questGiverName = initQuestGiverName
        questGiverImg = initQuestGiverImg
        
        
    }
}