//
//  LoginViewController.swift
//  Myriad
//
//  Created by Anthony Smith on 3/24/15.
//  Copyright (c) 2015 Anthony Smith. All rights reserved.
//


/*
Dear Myriad Team,

Thanks for the opportunity to test my skills. Trying to make an iOS app has been on college bucketlist for awhile now.

Sorry for using Swift instead of Objective C but my background is mostly in PHP so Swift seemed to come a little more naturally.

I'm afraid time constraints and other responsiblities are forcing me to turn this in early and incomplete.

I would love to hear from you but I'm not holding my breathe.

Still, Thanks,

Anthony Smith
*/







import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var emailTextBox: UITextField!
    
    

    
    @IBAction func submitButtonTapped(sender: AnyObject)
    {
        
        
        
        
        //Multiple layers of validation checking crammed into one 'if' statement because I only wanted to make one message box
        if ((!(nameTextBox.text == "" || emailTextBox == "")) && self.isValidEmail(self.emailTextBox.text))
        {
            //Grabbing values
            let textEmail : String = emailTextBox.text
            let textName : String = nameTextBox.text
            
            //Setup for POST -- Maybe I'm lacking some required knowledge but I don't believe there is any way for me to confirm that this is working
            let submitURL = NSURL(string: "https://challenge2015.myriadapps.com/api/v1/subscribe")
            let request = NSMutableURLRequest(URL: submitURL!)
            
            request.HTTPMethod = "POST"
            let postString = "email=\(textEmail)"
            
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            
            
            //I had assumed there was a post back with a confirmation of some kind but I couldn't get it working... The below block comment is my attempt to get JSON back from the API.
            
            //For all I know the API didn't return anything but that seemed really unlikely to me. This code probably just doesn't work.
            /*
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
                {
                    data, response, error in
                    
                    if error != nil
                    {
                        println("error")
                        return
                    }
                    
                    var err: NSError?
                    var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
                    
                    if let parseJSON = json
                    {
                        var resultValue = parseJSON["status"] as? String
                        println("result:\(resultValue)")
                    }
                    
            }
            */
            var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
            var context: NSManagedObjectContext = appDel.managedObjectContext!
            
            
            let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context) as NSManagedObject
            newUser.setValue(textName, forKey: "name")
            newUser.setValue(textEmail, forKey: "email")
            context.save(nil)
            
            self.performSegueWithIdentifier("loginSegue", sender: nil)
            
            
        }
        else
        {
            //Display message box
            let alert = UIAlertView()
            alert.title = "Sign In Failed"
            alert.message = "Please enter a valid name and email address"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "User")
        
        request.returnsObjectsAsFaults = false
        
        var results:NSArray = context.executeFetchRequest(request, error: nil)!
        if(results.count > 0)
        {
            var looping : Int = 0
            for res in results
            {
                var print = results[looping] as NSManagedObject
                println(print.valueForKey("email") as String)
                looping++
            }
        }
        else
        {
            println("no Results")
        }
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        if let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx) {
            return emailTest.evaluateWithObject(testStr)
        }
        return false
    }
    
    

}
