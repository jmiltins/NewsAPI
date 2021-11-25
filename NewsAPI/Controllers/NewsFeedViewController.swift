//
//  ViewController.swift
//  NewsAPI
//
//  Created by janis.miltins on 21/11/2021.
//

import UIKit
import SDWebImage

class NewsFeedViewController: UIViewController {
    

    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    //Topic button names
    @IBOutlet weak var newsTopicButtonName1: UIButton!
    
    @IBOutlet weak var newsTopicButtonName2: UIButton!
    
    @IBOutlet weak var newsTopicButtonName3: UIButton!
    
    @IBOutlet weak var newsTopicButtonName4: UIButton!
    //
    var newsItems: [NewsItem] = []
    //first News
    var searchResult = "techcrunch"
    // news titles
    let newsTitile1 = "Tech News"
    let newsTitile2 = "Apple News"
    let newsTitile3 = "Tesla News"
    let newsTitile4 = "Business News"
    
    //#warning("put your newsapi.org apikey here:")
    var apiKey = "a04fed7613e143d690a3a2b3a937a521"
    
    override func viewDidLoad() {
        //var currentNewsChoice = newsTitile1
        
        //button names
        newsTopicButtonName1.setTitle("Tech", for: .normal)
        newsTopicButtonName2.setTitle("Apple", for: .normal)
        newsTopicButtonName3.setTitle("Tesla", for: .normal)
        newsTopicButtonName4.setTitle("Business", for: .normal)
        super.viewDidLoad()
        //Title for tab, not to write manualy
        self.title = "TechNews"
        handleGetData()
        //conect in code or drag in
//        self.tblView.delegate
//        self.tblView.dataSource
    
        
    }
    // Buttons tapped
    @IBAction func newsTopicButton1(_ sender: Any) {
        searchResult = "techcrunch"
        self.title = newsTitile1
        //reload data
        handleGetData()
    }
    @IBAction func newsTopicButton2(_ sender: Any) {
        searchResult = "apple"
        self.title = newsTitile2
        handleGetData()
    }
    
    @IBAction func newsTopicButton3(_ sender: Any) {
        searchResult = "tesla"
        self.title = newsTitile3
        handleGetData()
    }
    
    @IBAction func newsTopicButton4(_ sender: Any) {
        searchResult = "business"
        self.title = newsTitile4
        handleGetData()
    }
    @IBAction func infoButtonTapped(_ sender: Any) {
        basicAlert(title: "Info", message: "In this section you will find articles. Click on article to read it")
    }
    
    func activityIndicator(animated: Bool){
        //bring new tread
        DispatchQueue.main.async {
            if animated{
                self.activityIndicatorView.isHidden = false
                self.activityIndicatorView.startAnimating()
            }else{
                self.activityIndicatorView.isHidden = true
                self.activityIndicatorView.stopAnimating()
            }
            
        }
    }

    func handleGetData(){
        
        activityIndicator(animated: true)
        let jsonUrl = "https://newsapi.org/v2/everything?q=\(searchResult)&from=2021-11-25&to=2021-11-05&sortBy=popularity&apiKey=\(apiKey)"
        
        guard let url = URL(string: jsonUrl) else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        // this line, because this JSON is Content-type
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        //complete from here
        URLSession(configuration: config).dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                print((error?.localizedDescription)!)
                self.basicAlert(title: "Error!", message: "\(String(describing: error?.localizedDescription))")
                return
            }
            guard let data = data else {
                self.basicAlert(title: "Error!", message: "Something weng wrong, no data.")
                return
            }
            do{
                let jsonData = try JSONDecoder().decode(Articles.self, from: data)
                
                self.newsItems = jsonData.articles
                DispatchQueue.main.async {
                    //print("self.newsItems", self.newsItems)
                    self.tblView.reloadData()
                    //stop activity indicator
                    self.activityIndicator(animated: false)
                }
            }catch{
                print("err:", error)
            }
        }.resume()
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "appleCell", for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        let item = newsItems[indexPath.row]
        // set label
        cell.newsTitleLabel.text = item.title
        cell.newsTitleLabel.numberOfLines = 0
        // set image
        cell.newsImageView.sd_setImage(with: URL(string: item.urlToImage), placeholderImage: UIImage(named: "news.png"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    //for detail view controller data
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        
        let item = newsItems[indexPath.row]
        
        vc.newsImage = item.urlToImage
        vc.titleString = item.title
        vc.webUrlString = item.url
        vc.contentString = item.description // edit to content
        
        //present(vc)
        //present(vc, animated: true, completion: nil)
        //or
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
