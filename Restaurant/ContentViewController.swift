//
//  ContentViewController.swift
//  Eateries
//
//  Created by Andrei Palonski on 01.11.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
  
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var subHeaderLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var pageButton: UIButton!
  
  var header = ""
  var subheader = ""
  var imageFile = ""
  var index = 0
  
  @IBAction func pageButtonPressed(_ sender: Any) {
    switch index {
    case 0:
      let pageVC = parent as! PageViewController
      pageVC.nextVC(atIndex: index)
    case 1:
      let userDefaults = UserDefaults.standard
      userDefaults.set(true, forKey: "wasIntroWatched")
      userDefaults.synchronize()
      
      dismiss(animated: true, completion: nil)
    default:
      break
    }
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pageButton.layer.cornerRadius = 15
    pageButton.clipsToBounds = true
    pageButton.layer.borderWidth = 2
    pageButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    pageButton.tintColor = .white
    pageButton.layer.borderColor = (#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)).cgColor
    
    switch index {
    case 0: pageButton.setTitle("Дальше", for: .normal)
    case 1: pageButton.setTitle("Начать", for: .normal)
    default:
      break
    }
    
    
    headerLabel.text = header
    subHeaderLabel.text = subheader
    imageView.image = UIImage(named: imageFile)
    pageControl.numberOfPages = 2
    pageControl.currentPage = index
    
    // Do any additional setup after loading the view.
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
