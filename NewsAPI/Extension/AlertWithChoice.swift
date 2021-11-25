//
//  AlertWithChoice.swift
//  NewsAPI
//
//  Created by janis.miltins on 25/11/2021.
//
import UIKit

extension UIViewController {
    func alertWithChoice(title: String?, message: String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}
