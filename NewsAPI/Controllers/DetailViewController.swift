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
    // for CoreData
    var savedItems = [Items]()
    var context: NSManagedObjectContext?
    
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
        
        
//#warning("//AppDelegate needed")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
//#warning("complete it")
    // core data logic
    func saveData(){
        do{
            try context?.save()
            //include basic alert
            basicAlert(title: "Saved!", message: "To see your saved article, go to Saved tab bar.")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let newItem = Items(context: self.context!)
        newItem.newsTitle = titleString
        newItem.newsContent = contentString
        newItem.url = webUrlString
        
        if !newsImage.isEmpty{
            newItem.image = newsImage
        }
        //append to saved items
        self.savedItems.append(newItem)
        saveData()
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        //"must guard it"
        guard let destinationVC: WebViewController = segue.destination as? WebViewController else {return}
        
        destinationVC.urlString = webUrlString
        // Pass the selected object to the new view controller.
    }
    
    
}
