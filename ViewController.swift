//
//  ViewController.swift
//  JsonParsingDemo
//
//  Created by Sagar Somaiya on 12/03/19.
//  Copyright © 2019 Sagar Somaiya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewList: UITableView!
    var arrayUser : [[String:Any]] = []
    var filteredData: [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewList.register(UINib(nibName: AllTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AllTableViewCell.identifier)
        self.tableViewList.rowHeight = UITableView.automaticDimension
        self.tableViewList.estimatedRowHeight = 100
        self.tableViewList.tableFooterView = UIView(frame: CGRect.zero)
        self.getDataFromapi()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getDataFromapi(){
        let parameters  : [String:Any] = [:]
        //let urlget1 = "http://www.mocky.io/v2/5c018aac3500005300ad0a12"
        let urlget2 = "https://api.androidhive.info/contacts/"
       /* let urlPost =  "http://www.mocky.io/v2/5c87c3bb32000069103bd4a2"
       //let urlPost = "http://www.mocky.io/v2/5c87d4ee32000043123bd51e"
        //urlPost request
        Alamofire.request(urlPost, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            print(response)
            if let responseDict = response.result.value{
                let json = JSON(responseDict)
                print(json)
                let dict = responseDict as? NSDictionary
                print(dict as Any)
              
                for (key,value) in (dict)! {
                    print(key)
                    print(value)
                    let first = key as! String
                    print(first)
                    if first != "result" {
                       self.arrayUser.append(value as! [String : Any])
                    }
                
                }
                print(self.arrayUser.count)
                self.filteredData = self.arrayUser
                self.tableViewList.delegate = self
                self.tableViewList.dataSource = self
                self.tableViewList.reloadData()
            }
        
        */
        
       /* //urlget1 request
        Alamofire.request(urlget1,headers : nil)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                print(response)
                if let responseDict = response.result.value{
                    let json = JSON(responseDict)
                    print(json["result"])
                    print(json["data"])
                    let dict = responseDict as? NSDictionary
                    self.arrayUser = dict!["data"] as! [[String:Any]]
                    self.filteredData = self.arrayUser
                    print(self.arrayUser)
                    print(self.arrayUser[0]["first_name"] ?? "")
                    self.tableViewList.delegate = self
                    self.tableViewList.dataSource = self
                    self.tableViewList.reloadData()
                }
        }*/
        //urlget2 request
        Alamofire.request(urlget2,headers : nil)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                print(response)
                if let responseDict = response.result.value {
                    let json = JSON(responseDict)
                    print(json)
                    print(json["contacts"])
                    let dict = responseDict as? NSDictionary
                    self.arrayUser = dict!["contacts"] as! [[String:Any]]
                    self.filteredData = self.arrayUser
                    print(self.arrayUser)
                    print(self.arrayUser[0]["name"] ?? "")
                    print(self.arrayUser[0])
                    print(self.arrayUser)
                    let  arrayphone : [String:Any]  = self.arrayUser[0]["phone"] as! [String:Any]
                    print(arrayphone["mobile"] ?? "")
                    
                    self.tableViewList.delegate = self
                    self.tableViewList.dataSource = self
                    self.tableViewList.reloadData()
                }
        }
    }
    


}
extension ViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewList.dequeueReusableCell(withIdentifier: AllTableViewCell.identifier, for: indexPath) as! AllTableViewCell
       /* for urlget1 and urlpost
         cell.labelFirstName.text = self.filteredData[indexPath.row]["first_name"] as? String
        cell.labelLastName.text = self.filteredData[indexPath.row]["last_name"] as? String
        cell.imageUser.sd_setImage(with: URL(string: (self.arrayUser[indexPath.row]["avatar"] as? String)!), completed: nil)*/
        ///* for urlget2
        cell.labelFirstName.text = self.filteredData[indexPath.row]["name"] as? String
        let  arrayphone : [String:Any]  = self.arrayUser[indexPath.row]["phone"] as! [String:Any]
        if arrayphone.count > 0 {
            print(arrayphone["mobile"] ?? "")
            cell.labelLastName.text = arrayphone["mobile"] as? String
        }
                
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.objData = self.filteredData[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            self.filteredData.remove(at: indexPath.row)
            
            tableViewList.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
           self.filteredData = arrayUser
        } else {
            filteredData.removeAll()
//            let searchPredicate = NSPredicate(format: "first_name like %@", searchText)
//            let array = (self.arrayUser as NSArray).filtered(using: searchPredicate)
            let array = self.arrayUser.filter { ($0["name"] as! String).range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil }
            self.filteredData = array
        }
        
        self.tableViewList.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
     self.filteredData = arrayUser
     self.tableViewList.reloadData()
    }
}
