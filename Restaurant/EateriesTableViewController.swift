//
//  EateriesTableViewController.swift
//  Eateries
//
//  Created by Andrei Palonski on 22.10.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit
import CoreData

class EateriesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  
  var restaurants: [Restaurant] = []
  var searchController : UISearchController! // объект, который будет заниматься поиском
  var filteredResultArray : [Restaurant] = [] // массив, в который будут попадать рестораны, соответствующие критерию поиска
  var fetchResultController: NSFetchedResultsController<Restaurant>!
  
  //  var restaurants: [Restaurant] = [
  //    Restaurant(name: "Ogonёk Grill&Bar", type: "Ресторан", location: "Уфа", image: "ogonek.jpg", isVisited: false),
  //    Restaurant(name: "Елу", type: "Ресторан", location: "Уфа", image: "elu.jpg", isVisited: false),
  //    Restaurant(name: "Bonsai", type: "Ресторан", location: "Уфа", image: "bonsai.jpg", isVisited: false),
  //    Restaurant(name: "Дастархан", type: "Ресторан", location: "Уфа", image: "dastarhan.jpg", isVisited: false),
  //    Restaurant(name: "Индокитай", type: "Ресторан", location: "Уфа", image: "indokitay.jpg", isVisited: false),
  //    Restaurant(name: "X.O", type: "Ресторан-клуб", location: "Уфа", image: "x.o.jpg", isVisited: false),
  //    Restaurant(name: "Балкан Гриль", type: "Ресторан", location: "Уфа", image: "balkan.jpg", isVisited: false),
  //    Restaurant(name: "Respublica", type: "Ресторан", location: "Уфа", image: "respublika.jpg", isVisited: false),
  //    Restaurant(name: "Speak Easy", type: "Ресторанный комплекс", location: "Уфа", image: "speakeasy.jpg", isVisited: false),
  //    Restaurant(name: "Morris Pub", type: "Ресторан", location: "Уфа", image: "morris.jpg", isVisited: false),
  //    Restaurant(name: "Вкусные истории", type: "Ресторан", location: "Уфа", image: "istorii.jpg", isVisited: false),
  //    Restaurant(name: "Классик", type: "Ресторан", location: "Уфа", image: "klassik.jpg", isVisited: false),
  //    Restaurant(name: "Love&Life", type: "Ресторан", location: "Уфа", image: "love.jpg", isVisited: false),
  //    Restaurant(name: "Шок", type: "Ресторан", location: "Уфа", image: "shok.jpg", isVisited: false),
  //    Restaurant(name: "Бочка", type: "Ресторан", location:  "Уфа", image: "bochka.jpg", isVisited: false)]
  
  @IBAction func close(segue: UIStoryboardSegue) {
    
  }
  
  //  var restaurantNames = ["Ogonёk Grill&Bar", "Елу", "Bonsai", "Дастархан", "Индокитай", "X.O", "Балкан Гриль", "Respublica", "Speak Easy", "Morris Pub", "Вкусные истории", "Классик", "Love&Life", "Шок", "Бочка"]
  //
  //  var restaurantImages = ["ogonek.jpg", "elu.jpg", "bonsai.jpg", "dastarhan.jpg", "indokitay.jpg", "x.o.jpg", "balkan.jpg", "respublika.jpg", "speakeasy.jpg", "morris.jpg", "istorii.jpg", "klassik.jpg", "love.jpg", "shok.jpg", "bochka.jpg"]
  //
  //  var restaurantIsVisited = [Bool](repeatElement(false, count: 15))
  
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.hidesBarsOnSwipe = true    // запрещаем прятаться  navigationbar до вызова функции viewDidLoad
  }
  
  func filterContentFor(searchText text: String) {
    filteredResultArray = restaurants.filter { (restaurant) -> Bool in
      return (restaurant.name?.lowercased().contains(text.lowercased()))!
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchController = UISearchController(searchResultsController: nil) // nil, так как мы хотим, чтобы результаты были прямо на главном экране и перекрывали таблицу ресторанов
    searchController.searchResultsUpdater = self // после подписки под протокол обязательно
    searchController.dimsBackgroundDuringPresentation = false // false, чтобы не затемнялся экран, когда происходит поиск
    tableView.tableHeaderView = searchController.searchBar // присваиваем хэддер tableView серчБар searchController'a
    searchController.searchBar.delegate = self // после подписки на протокол внизу
    searchController.searchBar.barTintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    searchController.searchBar.tintColor = .white // цвет текста
    definesPresentationContext = true
    
    tableView.estimatedRowHeight = 85
    tableView.rowHeight = UITableViewAutomaticDimension
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) // убираем или делаем пустой кнопку назад
    
    // создаем fetchRequest с фильтром сортировки по имени по возрастанию sortDescriptor и применяем его
    let fetchRequest : NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    // создаем и получаем доступ к контексту
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
      // создаем и инициализируем fetchResultController и передаем созданные выше fetchRequest и context
      fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
      fetchResultController.delegate = self // после подписания под протокол обязательно
      
      // пытаемся получить данные и если все успешно, то помещаем их в массив restaurants, если нет, то выводим ошибку
      do {
        try fetchResultController.performFetch()
        restaurants = fetchResultController.fetchedObjects!
      } catch let error as NSError {
        print(error.localizedDescription)
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    let userDefaults = UserDefaults.standard
    let wasIntroWatched = userDefaults.bool(forKey: "wasIntroWatched")
    guard !wasIntroWatched else {return}
    
    if let pageViewCoontroller = storyboard?.instantiateViewController(withIdentifier: "pageViewController") as? PageViewController {
      present(pageViewCoontroller, animated: true, completion: nil)
    }
  }
  
  // MARK: - Fetch Result Controller Delegate
  
  // предупреждает tableView, что сейчас будут обновления
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
    switch type {
    case .insert: guard let indexPath = newIndexPath else {break}
    tableView.insertRows(at: [indexPath], with: .fade)
    case .delete: guard let indexPath = indexPath else {break}
    tableView.deleteRows(at: [indexPath], with: .fade)
    case .update: guard let indexPath = indexPath else {break}
    tableView.reloadRows(at: [indexPath], with: .fade)
    default:
      tableView.reloadData()
    }
    restaurants = controller.fetchedObjects as! [Restaurant] // обновляем массив, так как он претерпел изменения
  }
  
  // предупреждает tableView, что обновления контента завершены
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  func restaurantToDisplayAt(indexPath: IndexPath) -> Restaurant {
    let restaurant: Restaurant
    if searchController.isActive && searchController.searchBar.text != "" {
      restaurant = filteredResultArray[indexPath.row] // если searchController.searchBar не пустой и активный, то отображаем массив ресторанов отсортированный
    } else {
      restaurant = restaurants[indexPath.row] // иначе тот что и был на главном экране
    }
    return restaurant
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    if searchController.isActive && searchController.searchBar.text != "" {
      return filteredResultArray.count
    }
    return restaurants.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EateriesTableViewCell
    
    let restaurant = restaurantToDisplayAt(indexPath: indexPath)
    
    cell.thumbnailImageView.image = UIImage(data: restaurant.image as! Data) // restaurants[indexPath.row].image as! Data) //UIImage(named: restaurants[indexPath.row].image)
    cell.thumbnailImageView.layer.cornerRadius = 32.5 // закругление краев изображения
    cell.thumbnailImageView.clipsToBounds = true  // позволяет обрезать изображение по нашему layer'y
    cell.nameLabel.text = restaurant.name // restaurants[indexPath.row].name
    cell.locationLabel.text = restaurant.location // restaurants[indexPath.row].location
    cell.typeLabel.text = restaurant.type // restaurants[indexPath.row].type
    
    //    if restaurantIsVisited[indexPath.row] {
    //    cell.accessoryType = .checkmark
    //    } else {
    //    cell.accessoryType = .none
    //    }
    
    cell.accessoryType = restaurant.isVisited ? .checkmark : .none
    // self.restaurants[indexPath.row].isVisited ? .checkmark : .none
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  //
  //  // метод который вызывается, когда тапаешь на ячейку
  //
  //  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  //
  //    let ac = UIAlertController(title: nil, message: "Выберите действие", preferredStyle: .actionSheet)
  //    //let call = UIAlertAction(title: "Позвонить + 375 (29) 7788 99\(index)", style: .default, handler: )
  //    // Создание контроллера внутри клоужера Невозможно совершить звонок
  //    let call = UIAlertAction(title: "Позвонить + 375 (29) 7788 99\(indexPath.row)", style: .default) {
  //
  //      (action: UIAlertAction) -> Void in
  //      let anotherAC = UIAlertController(title: "Ошибка", message: "Вызов невозможен", preferredStyle: .alert)
  //      let cnclButton = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
  //      anotherAC.addAction(cnclButton)
  //      self.present(anotherAC, animated: true, completion: nil)
  //    }
  //
  //    let isVisitedTitle = self.restaurantIsVisited[indexPath.row] ? "Я не был здесть" : "Я был здесь"
  //    let isVisited = UIAlertAction(title: isVisitedTitle, style: .default) { (action) in
  //      let cell = tableView.cellForRow(at: indexPath)
  //      self.restaurantIsVisited[indexPath.row] = !self.restaurantIsVisited[indexPath.row]
  //      cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
  //    }
  //
  //    let cancel = UIAlertAction(title: "Cancel?", style: .cancel, handler: nil)
  //    ac.addAction(call)
  //    ac.addAction(isVisited)
  //    ac.addAction(cancel)
  //
  //    present(ac, animated: true, completion: nil)
  //
  //    // убирает постоянно висящее выделение ячейки
  //    tableView.deselectRow(at: indexPath, animated: true)
  //
  //  }
  
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
      let defaultText = "Я сейчас в " + self.restaurants[indexPath.row].name!
      if let image = UIImage(data: self.restaurants[indexPath.row].image as! Data) { //UIImage(named: self.restaurants[indexPath.row].image) {
        
        let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
      }
    }
    
    let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
      self.restaurants.remove(at: indexPath.row)
      //self.restaurants.remove(at: indexPath.row) после введения ооп не нужно отдельно удалять, можно сразу целиком экземпляр удалять
      //self.restaurantImages.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      
      if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        let objectToDelete = self.fetchResultController.object(at: indexPath) // получили объект, который нужно удалить
        context.delete(objectToDelete)
        
        do {
          try context.save()
        } catch {
          print(error.localizedDescription)
        }
      }
      
    }
    share.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    delete.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    return [share, delete]
  }
  
  // передача данных между экранами с помощью сегвея
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "detailSegue" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let dvc = segue.destination as! EateriesDetailViewController
        dvc.restaurant = restaurantToDisplayAt(indexPath: indexPath)
        // self.restaurants[indexPath.row]
      }
    }
  }
}

extension EateriesTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    filterContentFor(searchText: searchController.searchBar.text!)
    tableView.reloadData()
  }
}

extension EateriesTableViewController: UISearchBarDelegate {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    if searchBar.text == "" {
      navigationController?.hidesBarsOnSwipe = false
    }
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    navigationController?.hidesBarsOnSwipe = true
  }
}
