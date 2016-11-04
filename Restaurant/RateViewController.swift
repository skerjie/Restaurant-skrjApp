//
//  RateViewController.swift
//  Eateries
//
//  Created by Andrei Palonski on 25.10.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {
  
  @IBOutlet weak var brilliantButton: UIButton!
  @IBOutlet weak var badButton: UIButton!
  @IBOutlet weak var goodButton: UIButton!
  @IBOutlet weak var ratingStackView: UIStackView!
  var restRating : String?
  
  @IBAction func rateRestaurant(sender: UIButton) {
    
    switch sender.tag {
    case 0: restRating = "bad"
    case 1: restRating = "good"
    case 2: restRating = "brilliant"
    default:
      break
    }
    
    performSegue(withIdentifier: "unwindSeguetoDVC", sender: sender)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    //    UIView.animate(withDuration: 0.4) {
    //      self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    //    }
    
    let buttonArray = [goodButton, badButton, brilliantButton]
    for (index, button) in buttonArray.enumerated() {
      let delay = Double(index) * 0.25
      UIView.animate(withDuration: 0.6, delay: delay, options: .curveEaseInOut, animations: {
        button?.transform = CGAffineTransform(scaleX: 1, y: 1)
      }, completion: nil)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    goodButton.transform = CGAffineTransform(scaleX: 0, y: 0)
    badButton.transform = CGAffineTransform(scaleX: 0, y: 0)
    brilliantButton.transform = CGAffineTransform(scaleX: 0, y: 0)
    
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.view.bounds // говорим, что размер фрэйма blurEffectView должен быть как рамки нашего вью
    blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    self.view.insertSubview(blurEffectView, at: 1)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
