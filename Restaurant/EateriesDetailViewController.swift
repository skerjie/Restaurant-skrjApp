//
//  EateriesDetailViewController.swift
//  Eateries
//
//  Created by Andrei Palonski on 24.10.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class EateriesDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var imageView: UIImageView!
  var restaurant: Restaurant?
  // var imageName = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: restaurant!.image)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4 // так как нужно всего 4 ряда
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EateriesDetailTableViewCell
    
    switch indexPath.row {
    case 0:
      cell.keyLabel.text = "Название"
      cell.valueLabel.text = restaurant!.name
    case 1:
      cell.keyLabel.text = "Тип"
      cell.valueLabel.text = restaurant!.type
    case 2:
      cell.keyLabel.text = "Адресс"
      cell.valueLabel.text = restaurant!.location
    case 3:
      cell.keyLabel.text = "Я там был?"
      cell.valueLabel.text = restaurant!.isVisited ? "Да" : "Нет"
    default:
      break
      
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}
