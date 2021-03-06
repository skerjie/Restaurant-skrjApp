//
//  NewEateryTableViewController.swift
//  Eateries
//
//  Created by Andrei Palonski on 27.10.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class NewEateryTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var adressTextField: UITextField!
  @IBOutlet weak var typeTextField: UITextField!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var noButton: UIButton!
  @IBOutlet weak var yesButton: UIButton!
  var isVisited = false
  
  @IBAction func toggleIsVisitedPressed(_ sender: UIButton) {
    if sender == yesButton {
      sender.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
      noButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
      isVisited = true
    } else {
      sender.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
      yesButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
      isVisited = false
    }
  }
  
  @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    if nameTextField.text == "" || adressTextField.text == "" || typeTextField.text == "" {
      let ac = UIAlertController(title: "Ошибка", message: "Не все поля заполнены", preferredStyle: .alert)
      let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
      ac.addAction(cancel)
      present(ac, animated: true, completion: nil)
    } else {
      
      // добираемся до контекста(context)
      if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        // создаем экземпляр ресторана в контексте
        let restaurant = Restaurant(context: context)
        restaurant.name = nameTextField.text
        restaurant.location = adressTextField.text
        restaurant.type = typeTextField.text
        restaurant.isVisited = isVisited
        if let image = imageView.image {
          // чтобы получить изображение как бинари дата нужно кастить к NSData и метод UIImagePNGRepresentation, так как изображения в  PNG
          restaurant.image = UIImagePNGRepresentation(image) as NSData?
        }
        do {
          try context.save()
          print("Сохранение удалось")
        } catch let error as NSError {
          print("Не удалось сохранить данные \(error), \(error.userInfo)")
        }
      }
      
      performSegue(withIdentifier: "unwindSegueFromNewEatery", sender: self)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    yesButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    yesButton.layer.cornerRadius = 15
    yesButton.clipsToBounds = true
    
    noButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    noButton.layer.cornerRadius = 15
    noButton.clipsToBounds = true
    
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    dismiss(animated: true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      let alertController = UIAlertController(title: "Источник фотографий", message: nil, preferredStyle: .alert)
      let cameraAction = UIAlertAction(title: "Камера", style: .default, handler: { (action) in
        self.chooseimagePickerAction(source: .camera) // передаем камера
      })
      let photoAction = UIAlertAction(title: "Фото", style: .default, handler: { (action) in
        self.chooseimagePickerAction(source: .photoLibrary) // передаем фотобиблиотеку
      })
      let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
      alertController.addAction(cameraAction)
      alertController.addAction(photoAction)
      alertController.addAction(cancelAction)
      self.present(alertController, animated: true, completion: nil)
    }
    tableView.deselectRow(at: indexPath, animated: true) // снимаем выделение с ячейки
  }
  
  // выбор источника для фото
  func chooseimagePickerAction(source: UIImagePickerControllerSourceType) {
    if UIImagePickerController.isSourceTypeAvailable(source) { // проверка есть ли в телефоне возможность камеры или фото
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self     // после подписки на протоколы обязательно нужно так сделать
      imagePicker.allowsEditing = true // разрешаем редактировать фото, обрезка и т.д.
      imagePicker.sourceType = source // тут мы передаем тот source  или камера или фото по дефолту .camera . photoLibrary
      self.present(imagePicker, animated: true, completion: nil)
    }
  }
}
