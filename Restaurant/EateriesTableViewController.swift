//
//  EateriesTableViewController.swift
//  Eateries
//
//  Created by Andrei Palonski on 22.10.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class EateriesTableViewController: UITableViewController {
  
  var restaurantNames = ["Ogonёk Grill&Bar", "Елу", "Bonsai", "Дастархан", "Индокитай", "X.O", "Балкан Гриль", "Respublica", "Speak Easy", "Morris Pub", "Вкусные истории", "Классик", "Love&Life", "Шок", "Бочка"]
  
  var restaurantImages = ["ogonek.jpg", "elu.jpg", "bonsai.jpg", "dastarhan.jpg", "indokitay.jpg", "x.o.jpg", "balkan.jpg", "respublika.jpg", "speakeasy.jpg", "morris.jpg", "istorii.jpg", "klassik.jpg", "love.jpg", "shok.jpg", "bochka.jpg"]
  
  var restaurantIsVisited = [Bool](repeatElement(false, count: 15))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return restaurantNames.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EateriesTableViewCell
    
    cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
    cell.thumbnailImageView.layer.cornerRadius = 32.5 // закругление краев изображения
    cell.thumbnailImageView.clipsToBounds = true  // позволяет обрезать изображение по нашему layer'y
    cell.nameLabel.text = restaurantNames[indexPath.row]
    
    //    if restaurantIsVisited[indexPath.row] {
    //    cell.accessoryType = .checkmark
    //    } else {
    //    cell.accessoryType = .none
    //    }
    
    cell.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
    
    return cell
  }
  
  
  // метод который вызывается, когда тапаешь на ячейку
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let ac = UIAlertController(title: nil, message: "Выберите действие", preferredStyle: .actionSheet)
    //let call = UIAlertAction(title: "Позвонить + 375 (29) 7788 99\(index)", style: .default, handler: )
    // Создание контроллера внутри клоужера Невозможно совершить звонок
    let call = UIAlertAction(title: "Позвонить + 375 (29) 7788 99\(indexPath.row)", style: .default) {
      
      (action: UIAlertAction) -> Void in
      let anotherAC = UIAlertController(title: "Ошибка", message: "Вызов невозможен", preferredStyle: .alert)
      let cnclButton = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
      anotherAC.addAction(cnclButton)
      self.present(anotherAC, animated: true, completion: nil)
    }
    
    let isVisitedTitle = self.restaurantIsVisited[indexPath.row] ? "Я не был здесть" : "Я был здесь"
    let isVisited = UIAlertAction(title: isVisitedTitle, style: .default) { (action) in
      let cell = tableView.cellForRow(at: indexPath)
      self.restaurantIsVisited[indexPath.row] = !self.restaurantIsVisited[indexPath.row]
      cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
    }
    
    let cancel = UIAlertAction(title: "Cancel?", style: .cancel, handler: nil)
    ac.addAction(call)
    ac.addAction(isVisited)
    ac.addAction(cancel)
    
    present(ac, animated: true, completion: nil)
    
    // убирает постоянно висящее выделение ячейки
    tableView.deselectRow(at: indexPath, animated: true)
    
  }
  
  //  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
  //
  //    if editingStyle == .delete {
  //      self.restaurantIsVisited.remove(at: indexPath.row)
  //      self.restaurantNames.remove(at: indexPath.row)
  //      self.restaurantImages.remove(at: indexPath.row)
  //    }
  //    //tableView.reloadData()  // перегружаю таблицу после удаления
  //    tableView.deleteRows(at: [indexPath], with: .fade) // удаление одной ячейки с анимацией затухания и смещения ячейки наверх, без необходимости обновлять всю таблицу reloadData не нужен
  //  }
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let share = UITableViewRowAction(style: .default, title: "Поделиться?") { (action, indexPath) in
      let defaultText = "Я сейчас в " + self.restaurantNames[indexPath.row]
      if let image = UIImage(named: self.restaurantImages[indexPath.row]) {
        let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
      }
    }
    
    let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
      self.restaurantIsVisited.remove(at: indexPath.row)
      self.restaurantNames.remove(at: indexPath.row)
      self.restaurantImages.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
    share.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    delete.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    return [share, delete]
  }
  
}
