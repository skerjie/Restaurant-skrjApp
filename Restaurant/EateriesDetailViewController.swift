//
//  EateriesDetailViewController.swift
//  Eateries
//
//  Created by Andrei Palonski on 24.10.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class EateriesDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var mapButton: UIButton!
  @IBOutlet weak var rateButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var imageView: UIImageView!
  var restaurant: Restaurant?
  // var imageName = ""
  
  @IBAction func unwindSegue(segue: UIStoryboardSegue) {
    guard let svc = segue.source as? RateViewController else {
      return
    }
    guard let rating = svc.restRating else {
      return
    }
    rateButton.setImage(UIImage(named: rating), for: .normal)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.hidesBarsOnSwipe = false
    navigationController?.setNavigationBarHidden(false, animated: true) // запрещаем прятаться  navigationbar до вызова функции viewDidLoad
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let buttons = [rateButton, mapButton]
    
    for button in buttons {
      guard let button = button else {break} // сначала извлекаем кнопку, чтобы потом отдельно каждую кнопку не делать опциональной ?
      button.layer.cornerRadius = 5
      button.layer.borderWidth = 1 // толщина рамочки
      button.layer.borderColor = UIColor.white.cgColor
    }
    
    tableView.estimatedRowHeight = 38
    tableView.rowHeight = UITableViewAutomaticDimension
    imageView.image = UIImage(named: restaurant!.image)
    
    //      tableView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    //      tableView.separatorColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    tableView.tableFooterView = UIView(frame: .zero) // остальные строки  скрываем
    title = restaurant!.name
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
    cell.backgroundColor = UIColor.clear // делает ячейки прозрачными
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "mapSegue" {
    let dvc = segue.destination as! MapViewController
      dvc.restaurant = self.restaurant
    }
  }
  
}
