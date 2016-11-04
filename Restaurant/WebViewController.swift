//
//  WebViewController.swift
//  Eateries
//
//  Created by Andrei Palonski on 02.11.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
  
  var url : URL!
  var webView : WKWebView!
  var progressView : UIProgressView!
  
  deinit {
    webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress)) // отпускаем обсервер после ухода со страницы обратно в страницу  О Нас
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView  // заменяем view на webView и теперь оно занимает все расстояние
    
    let request = URLRequest(url: url)
    webView.load(request)
    webView.allowsBackForwardNavigationGestures = true
    
    progressView = UIProgressView(progressViewStyle: .default) // создаем progressView
    progressView.sizeToFit() // занимает столько места сколько ему нужно
    
    let progressButton = UIBarButtonItem(customView: progressView) // размещаем progressButton вместо кнопок TabBar'a
    let flexibleSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: #selector(webView.reload))
    
    toolbarItems = [progressButton, flexibleSpacer, refreshButton]
    navigationController?.isToolbarHidden = false
    
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) // подписываем наблюдателя за наблюдением за изменением состояния webView
    
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(webView.estimatedProgress)
    }
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
