//
//  MapViewController.swift
//  Eateries
//
//  Created by Andrei Palonski on 27.10.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
  
  var restaurant: Restaurant!
  let geocoder = CLGeocoder()

  @IBOutlet weak var mapView: MKMapView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      mapView.delegate = self

      geocoder.geocodeAddressString(restaurant.location) { (placemarks, error) in
        guard error == nil else {return}
        guard let placemarks = placemarks else {return}
        
        let placemark = placemarks.first!
        
        let annotation = MKPointAnnotation()
        annotation.title = self.restaurant.name
        annotation.subtitle = self.restaurant.type
        
        guard let location = placemark.location else {return}
        annotation.coordinate = location.coordinate
        
        self.mapView.showAnnotations([annotation], animated: true) // показываем аннотацию
        self.mapView.selectAnnotation(annotation, animated: true) // разворачиваем чтобы посмотреть детально
      }
      
    }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    guard !(annotation is MKUserLocation) else {return nil} // проверка является ли аннотация нашим местоположением или другой какой-то точки
    let annotationIdentifier = "restAnnotation"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView // создаем переиспользуемую ячейку и кастим к MKPinAnnotationView чтобы видеть булавку
    
    // если не удалось создать переиспользуемую ячейку, то создаем вручную
    if annotationView == nil {
    annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
      annotationView?.canShowCallout = true // позволяет отображать дополнительную аннотацию созданную ниже, а именно картинку
    }
    
    let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) // создаем пустую рамочку для изображения справа от аннотации
    annotationView?.rightCalloutAccessoryView = rightImage // справа от аннотации
    annotationView?.pinTintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) // цвет булавки
    return annotationView

  }

}
