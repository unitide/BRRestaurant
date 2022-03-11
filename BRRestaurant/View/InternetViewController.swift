//
//  InternetViewController.swift
//  BRRestaurantApp
//
//  Created by Mingyong Zhu on 3/9/22.
//

import UIKit
import WebKit

class InternetViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var myWebView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
   private lazy var myToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        var items = [UIBarButtonItem]()
       
        items.append(UIBarButtonItem(image: UIImage(named: "icWebBack"), style: .plain, target: self, action: #selector(backToPreviousPage)))
        items.append(UIBarButtonItem.fixedSpace(10))
        items.append(UIBarButtonItem(image: UIImage(named: "icWebRefresh"), style: .plain, target: self, action: #selector(refreshCurrentPage)))
        items.append(UIBarButtonItem.fixedSpace(10))
        items.append(UIBarButtonItem(image: UIImage(named: "icWebForward"), style: .plain, target: self, action: #selector(forwardToNextPage)))
        toolBar.setItems(items, animated: true)
        return toolBar
    }()
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        lookupWebPage(address: NetworkURLs.webAddress)
    }
    
    // MARK: - Actions for ButtonItems
    @objc
    private func backToPreviousPage(_ sender: UIBarButtonItem) {
        self.myWebView.goBack()
    }
    
    @objc
    private func refreshCurrentPage(_ sender: UIBarButtonItem) {
        if let url = myWebView.backForwardList.currentItem?.url {
            lookupWebPageByURL(url: url)
        }
    }
    
    @objc
    private func forwardToNextPage(_ sender: UIBarButtonItem) {
        self.myWebView.goForward()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        // Setup too bar attributes
        myToolBar.barTintColor = UIColor(named: "viewBackgroundColor")
        myToolBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myToolBar)
        
        let safeGuide = self.view.safeAreaLayoutGuide
        myToolBar.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        myToolBar.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        myToolBar.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        myToolBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // Setup webView attributes
        myWebView.backgroundColor = UIColor(named: "viewBackgroundColor")
        self.view.addSubview(myWebView)
        myWebView.translatesAutoresizingMaskIntoConstraints = false
        myWebView.topAnchor.constraint(equalTo: myToolBar.bottomAnchor).isActive = true
        myWebView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        myWebView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        myWebView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
        
    }
    
    private func lookupWebPage(address: String) {
        if let url = URL(string: address) {
            let request = URLRequest(url: url)
            myWebView.load(request)
        }
    }
    
    private func lookupWebPageByURL(url: URL) {
        let request = URLRequest(url: url)
        myWebView.load(request)
    }
}
