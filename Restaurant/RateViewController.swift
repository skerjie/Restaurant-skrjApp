//
//  RateViewController.swift
//  Eateries
//
//  Created by Andrei Palonski on 25.10.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
