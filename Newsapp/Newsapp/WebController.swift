//
//  WebController.swift
//  Newsapp
//
//  Created by Stanley Delacruz on 6/18/17.
//  Copyright © 2017 Stanley Delacruz. All rights reserved.
//

import UIKit

class WebController: UIViewController, UIWebViewDelegate {
    
    let webView: UIWebView = {
        let wv = UIWebView()
        return wv
    }()
    
    var newsUrl: String? {
        didSet {
            if let url = URL(string: newsUrl!) {
                let request = URLRequest(url: url)
                webView.loadRequest(request)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        navigationController?.navigationBar.barTintColor = UIColor.black
        webView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        webView.delegate = self
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self , action: #selector(handleCancel))
    }
    
    func handleCancel() {
        dismiss(animated: true , completion: nil)
    }
}
