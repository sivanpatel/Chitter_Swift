//
//  TimelineTableViewController.swift
//  Chitter
//
//  Created by Sivan Patel on 25/08/2015.
//  Copyright (c) 2015 Sivan Patel. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {
  
  var timelineData:NSMutableArray = NSMutableArray()
  
  override func viewDidAppear(animated: Bool) {
    
      self.loadData()
    
      if ((PFUser.currentUser()) == nil) {
        var loginAlert:UIAlertController = UIAlertController(title: "Sign up/Login", message: "Please sign up or login", preferredStyle: UIAlertControllerStyle.Alert)
          loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "Your username"
          })
        loginAlert.addTextFieldWithConfigurationHandler({
          textfield in
          textfield.placeholder = "Your password"
          textfield.secureTextEntry = true
        })
        loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
          alertAction in
          let textFields:NSArray = loginAlert.textFields! as NSArray
          let usernameTextfield:UITextField = textFields.objectAtIndex(0) as! UITextField
          let passwordTextfield:UITextField = textFields.objectAtIndex(1) as! UITextField
          
          PFUser.logInWithUsernameInBackground(usernameTextfield.text, password: passwordTextfield.text){
            (user, error)->Void in
            if ((user) != nil){
              println("Login successful")
            } else {
              println("Login failed")
            }
          }
        }))
        
        loginAlert.addAction(UIAlertAction(title: "Sign up", style: UIAlertActionStyle.Default, handler: {
          alertAction in
          let textFields:NSArray = loginAlert.textFields! as NSArray
          let usernameTextfield:UITextField = textFields.objectAtIndex(0) as! UITextField
          let passwordTextfield:UITextField = textFields.objectAtIndex(1) as! UITextField
          
          var peeper:PFUser = PFUser()
          peeper.username = usernameTextfield.text
          peeper.password = passwordTextfield.text
        
          peeper.signUpInBackgroundWithBlock{
            (succeeded, error)->Void in
            if error == nil {
              println("Sign up successful")
            } else {
              println("\(error)")
            }
          }
        
        }))
        self.presentViewController(loginAlert, animated: true, completion: nil)
      }
  }
  

  @IBAction func loadData() {
    timelineData.removeAllObjects()
    
    var findTimelineData:PFQuery = PFQuery(className: "Peeps")
    
    findTimelineData.findObjectsInBackgroundWithBlock{
      (objects, error)-> Void in
      if error == nil {
        for object in objects!{
          self.timelineData.addObject(object)
        }
        var array:NSMutableArray = NSMutableArray(array: self.timelineData.reverseObjectEnumerator().allObjects)
        self.timelineData = array as NSMutableArray
        
        self.tableView.reloadData()
      }
    }
  }
 
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return timelineData.count
    }

  
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell:PeepTableViewCell = tableView!.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PeepTableViewCell
      
      let peep:PFObject = self.timelineData.objectAtIndex(indexPath.row) as! PFObject
      
      cell.peepTextView.alpha = 0
      cell.timestampLabel.alpha = 0
      cell.usernameLabel.alpha = 0
      

      cell.peepTextView.text = peep.objectForKey("content") as! String
      
      var dateFormatter:NSDateFormatter = NSDateFormatter()
      dateFormatter.dateFormat="yyyy-MM-dd HH:mm"
      cell.timestampLabel.text = dateFormatter.stringFromDate(peep.createdAt!)
      
      var findPeeper:PFQuery = PFUser.query()!
        findPeeper.whereKey("objectId", equalTo: peep.objectForKey("peeper")!.objectId!!)
      
      findPeeper.findObjectsInBackgroundWithBlock{
        (objects:[AnyObject]?, error:NSError?)-> Void in
        if error == nil {
          let user:PFUser = (objects! as NSArray).lastObject as! PFUser
          
          cell.usernameLabel.text = user.username
          
          UIView.animateWithDuration(0.5, animations: {
            cell.peepTextView.alpha = 1
            cell.timestampLabel.alpha = 1
            cell.usernameLabel.alpha = 1
          })
        }
      }
        return cell
    }
    
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
