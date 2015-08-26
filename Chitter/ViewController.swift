//
//  ViewController.swift
//  Chitter
//
//  Created by Sivan Patel on 25/08/2015.
//  Copyright (c) 2015 Sivan Patel. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

  override func viewDidLoad() {
    
    let testObject = PFObject(className: "TestObject")
    testObject["foo"] = "bar"
    testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      println("Object has been saved.")
    }
    
    super.viewDidLoad()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

