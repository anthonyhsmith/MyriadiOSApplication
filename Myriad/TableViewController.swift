//
//  TableViewController.swift
//  Myriad
//
//  Created by Anthony Smith on 3/21/15.
//  Copyright (c) 2015 Anthony Smith. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var kingdomList: [Kingdom] = []
    
    @IBOutlet weak var kingdomTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //URL to JSON Data
        let url = NSURL(string: "https://challenge2015.myriadapps.com/api/v1/kingdoms")
        
        //Connects to the server and makes the request
        var request = NSURLRequest(URL: url!)
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        //If there is data runs a loop to parse all the JSON data, else sends an error
        if data != nil {
            var kingdomData = JSON(data: data!)

            
            var currentKingdom = 0
            for (key: String, subJson: JSON) in kingdomData
            {
                var kingdomId : Int = kingdomData[currentKingdom]["id"].int!
                var kingdomName : String = kingdomData[currentKingdom]["name"].stringValue
                var kingdomImgURL : String = kingdomData[currentKingdom]["image"].stringValue
                
                var newKingdom = Kingdom(initId : kingdomId, initName : kingdomName, initImgURL : kingdomImgURL)
                kingdomList.append(newKingdom)
                currentKingdom++
            }
            
        }
        else
        {
            //ERROR MESSAGE GOES HERE
        }
        
        self.kingdomTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.kingdomTable.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func logOutPress(sender: AnyObject) {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kingdomList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = self.kingdomTable.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = self.kingdomList[indexPath.row].name
        return cell
        
    }
}

