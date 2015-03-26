//
//  Kingdom.swift
//  Myriad
//
//  Created by Anthony Smith on 3/21/15.
//  Copyright (c) 2015 Anthony Smith. All rights reserved.
//

import Foundation

class Kingdom {
    var id : Int
    var name : String
    var imgURL : String
    var questList : [Quest] = []
    init (initId : Int, initName : String, initImgURL : String ) {
        id = initId
        name = initName
        imgURL = initImgURL
        
        self.getQuests()
        
    }
    func getQuests () {

        //URL to JSON Data, Appends ID to end of string to get kingdom specifics
        let url = NSURL(string: "https://challenge2015.myriadapps.com/api/v1/kingdoms/" + String(id))

        //Connects to the server and makes the request
        var request = NSURLRequest(URL: url!)
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        //If there is data runs a loop to parse all the JSON data, else sends an error
        if data != nil {
            var questData = JSON(data: data!)
            
            var questList: [Quest] = []
            var currentQuest = 0

            for (key: String, subJson: JSON) in questData["quests"]
            {
                var questID : String = questData["quests"][currentQuest]["id"].stringValue
                var questName : String = questData["quests"][currentQuest]["name"].stringValue
                
                var questGiverID : String = questData["quests"][currentQuest]["giver"]["id"].stringValue
                var questGiverName : String = questData["quests"][currentQuest]["giver"]["name"].stringValue
                var questGiverImg : String = questData["quests"][currentQuest]["giver"]["image"].stringValue
                
                //Values not being used... Uncomment if you want to make use of them in the future
                //var questDescription : String = questData["quests"][currentQuest]["description"].stringValue
                //var questImg :String  = questData["quests"][currentQuest]["image"].stringValue
                
                var newQuest = Quest(initQuestId: questID, initQuestName: questName, initQuestImgURL: "", initQuestDescription: "", initQuestGiverID: questGiverID, initQuestGiverName: questGiverName, initQuestGiverImg: questGiverImg)
                questList.append(newQuest)
                
                currentQuest++
            }
            println(questList.count)
            
        }
        
        
        
        
        
        
        
        
        
        
    }
}