//
//  ComposeViewController.swift
//  Chitter
//
//  Created by Sivan Patel on 25/08/2015.
//  Copyright (c) 2015 Sivan Patel. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

  @IBOutlet weak var peepTextView: UITextView! = UITextView()
  
  
  @IBOutlet weak var characterRemaining: UILabel! = UILabel() 
  
  
  @IBAction func sendPeep(sender: AnyObject) {
    var peep:PFObject = PFObject(className: "Peeps")
    peep["content"] = peepTextView.text
    peep["peeper"] = PFUser.currentUser()
    
    peep.saveInBackground()
    
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
  
  func textView(textView: UITextView!,
    shouldChangeTextInRange range: NSRange,
    replacementText text: String!) -> Bool{
      
      var newLength:Int = (textView.text as NSString).length + (text as NSString).length - range.length
      var remainingCharacters:Int = 140 - newLength
      
      characterRemaining.text = "\(remainingCharacters)"
      
      return (newLength > 140) ? false : true
      
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        peepTextView.layer.borderColor = UIColor.blackColor().CGColor
        peepTextView.layer.borderWidth = 0.5
        peepTextView.layer.cornerRadius = 5
        peepTextView.delegate = self
      
      
        peepTextView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
