//
//  DetailViewController.swift
//  NewsAPI
//
//  Created by janis.miltins on 23/11/2021.
//

import UIKit
import SDWebImage
import CoreData



class DetailViewController: UIViewController {
    
    var webUrlString = String()
    var titleString = String()
    var contentString = String()
    var newsImage = String()

    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleString
        contentTextView.text = contentString
        newsImageView.sd_setImage(with: URL(string:newsImage), placeholderImage: UIImage(named: "news.png"))
        //AppDelegate needed

    }
    #warning("complete it")
    // core data logic
    //saveData()
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
#warning("must guard it")
        let destinationVC: WebViewController = segue.destination as! WebViewController
        
        destinationVC.urlString = webUrlString
        // Pass the selected object to the new view controller.
    }
    

}
