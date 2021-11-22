//
//  ViewController.swift
//  NewsAPI
//
//  Created by janis.miltins on 21/11/2021.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    var newsItems: [NewsItem] = []
    var searchResult = "apple"
    //#warning("put your newsapi.org apikey here:")
    var apiKey = "a04fed7613e143d690a3a2b3a937a521"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Apple News"
        handleGetData()
    }

    func handleGetData(){
        let jsonUrl = "https://newsapi.org/v2/everything?q=\(searchResult)&from=2021-11-19&to=2021-11-05&sortBy=popularity&apiKey=\(apiKey)"
        
        guard let url = URL(string: jsonUrl) else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        //complete from here
        URLSession(configuration: config).dataTask(with: urlRequest) { (data, response, error)  in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            guard let data = data else {
                print(String(describing: error))
                self.basicAlert(title: "Error: ", message: "\(String(describing: error?.localizedDescription))")
                return
            }
            do{
                let jsonData = try JSONDecoder().decode(Articles.self, from: data)
                self.newsItems = jsonData.articles
                DispatchQueue.main.async {
                    print("jsonData", jsonData)
                    self.tableViewOutlet.reloadData()
                }
            }catch{
                print("err:", error)
            }
        }.resume()
    }
}

