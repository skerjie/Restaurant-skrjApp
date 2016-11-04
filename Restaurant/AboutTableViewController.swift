//
//  AboutTableViewController.swift
//  Eateries
//
//  Created by Andrei Palonski on 02.11.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {
  
  let sectionsHeaders = ["В социальных сетях", "Ссылки на страницы"]
  let sectionsContent = [["Facebook", "VK"], ["facebook.com", "vk.com"]]
  let firstSectionLinks = ["https://www.facebook.com/andrey.polonskiy", "https://vk.com/andy_skrj"]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.tableFooterView = UIView(frame: .zero)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return sectionsHeaders.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionsHeaders[section]
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return sectionsContent[section].count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    cell.textLabel?.text = sectionsContent[indexPath.section][indexPath.row]
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 0:
      switch indexPath.row {
      case 0..<firstSectionLinks.count:
        performSegue(withIdentifier: "showWebPageSegue", sender: self)
      default:
        break
      }
    default:
      break
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showWebPageSegue" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let dvc = segue.destination as! WebViewController
        dvc.url = URL(string: firstSectionLinks[indexPath.row])
      }
    }
  }
}
