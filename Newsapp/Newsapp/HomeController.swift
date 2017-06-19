//
//  ViewController.swift
//  Newsapp
//
//  Created by Stanley Delacruz on 6/17/17.
//  Copyright © 2017 Stanley Delacruz. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    
    var news: [News]?
    let items = ["ESPN", "IGN", "Business-Insider", "Buzzfeed", "Bloomberg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.red, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)]
        title = "ESPN"
        collectionView?.register(NewsCell.self , forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        fetchNews(channel: "espn")
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "ESPN", items: items as [AnyObject])
        
        
        self.navigationItem.titleView = menuView
        
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = .white
        
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            self?.fetchNews(channel: (self?.items[indexPath])!)
        }
    }
    
    func fetchNews(channel: String) {
        let yourApiKey = ""
        //get your api key from newsapi.org
        let url = URL(string: "https://newsapi.org/v1/articles?source=\(channel)&sortBy=top&apiKey=\(yourApiKey)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            self.news = [News]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                let articles = json?["articles"] as? [[String: Any]]
                for dictionary in articles! {

                    let new = News()
                    new.authorName = dictionary["author"] as? String ?? "Unknown Author"
                    new.imageName = dictionary["urlToImage"] as? String
                    new.title = dictionary["title"] as? String ?? "Unknown Title"
                    new.urlToWebsite = dictionary["url"] as? String
                    self.news?.append(new)
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            
            }.resume()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = news?.count {
            return count
        }
        
        return 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsCell
        cell.new = news?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let new = news?[indexPath.item]
        let controller = WebController()
        controller.newsUrl = new?.urlToWebsite
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true , completion: nil)
    }
}

