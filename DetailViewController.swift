//
//  DetailViewController.swift
//  JsonParsingDemo
//
//  Created by Sagar Somaiya on 12/03/19.
//  Copyright © 2019 Sagar Somaiya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var objData : [String:Any] = [:]
    
    @IBOutlet weak var clickBack: UIButton!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLName: UILabel!
    @IBOutlet weak var labelid: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelAddreess: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(objData)
        // url get2
        self.labelName.text = objData["name"] as? String
        self.labelLName.text = objData["email"] as? String
        self.labelid.text = objData["address"] as? String
         self.labelAddreess.text = objData["gender"] as? String
        let arrayphone : [String:Any] = objData["phone"] as! [String:Any]
        if arrayphone.count > 0 {
            self.labelPhone.text = arrayphone["mobile"] as? String
        }
        
        
        /*//urlget1 and url post
        self.labelName.text = objData["first_name"] as? String
        self.labelLName.text = objData["last_name"] as? String
        self.labelid.text = objData["id"] as? String
        self.labelAddreess.text = "Blank" as? String
        self.labelPhone.text = "mobile" as? String*/
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
