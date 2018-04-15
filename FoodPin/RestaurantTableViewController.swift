//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 24/8/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController , UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    var restaurantIsVisited = [Bool]()
    
    var getText: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...restaurantNames.count {
            restaurantIsVisited.append(false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!
        RestaurantTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        
        cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none
        
        return cell
    }
    
    //彈出選單功能
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let optionMenu = UIAlertController(title: nil, message: "What?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let checkInActopn = UIAlertAction(title: "Check in", style: .default, handler: { (action: UIAlertAction!) ->
            Void in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            self.restaurantIsVisited[indexPath.row] = true
            
        })
        
        let callerActionHandler = { (action: UIAlertAction!) -> Void in
            
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry",
                                                 preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        let callAction = UIAlertAction(title: "Call" + "123-000-\(indexPath.row)", style: .default,
                                       handler: callerActionHandler)
        
        optionMenu.addAction(checkInActopn)
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(callAction)
        
        present(optionMenu, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    fileprivate func extractedFunc(_ detectAction: UIContextualAction, _ shareAction: UIContextualAction) ->
        UISwipeActionsConfiguration {
            return UISwipeActionsConfiguration(actions: [detectAction, shareAction])
    }
    
    //實作左滑刪除
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
        UISwipeActionsConfiguration? {
            
            
            let detectAction = UIContextualAction(style: .destructive, title: "Delete") {
                (action, sourceview, completionHandler) in
                
                self.restaurantNames.remove(at: indexPath.row)
                self.restaurantLocations.remove(at: indexPath.row)
                self.restaurantTypes.remove(at: indexPath.row)
                self.restaurantIsVisited.remove(at: indexPath.row)
                self.restaurantImages.remove(at: indexPath.row)
                
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                
                completionHandler(true)
            }
            
            //添加左滑分享選項
            let shareAction = UIContextualAction(style: .normal, title: "Edit") {
                (action, sourceView, completionHandler) in
                
                
                self.dialogBox()
                
                
                /* func textFiled(textField: UITextField){
                 self.restaurantNames[indexPath.row] = textField.text!
                 }*/
                /*
                 let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]
                 let activityController: UIActivityViewController
                 
                 if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row]) {
                 
                 activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                 }3 else {
                 activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                 }
                 
                 self.present(activityController, animated: true, completion: nil)
                 
                 completionHandler(true)
                 */
            }
            
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [detectAction, shareAction])
            
            return swipeConfiguration
            
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
        UISwipeActionsConfiguration? {
            
            
            let cellIdentifier = "Cell"
            _ = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!
            RestaurantTableViewCell
            let changePicButton = UIContextualAction(style: .normal, title: "Picture") { (action, sourceView, completionHandler) in
                
                
                self.photoLibrary()
                
                /*
                 func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
                 
                 self.restaurantImages[indexPath.row] = info[UIImagePickerControllerOriginalImage] as? UIImage
                 self.dismissViewControllerAnimated(true, completion: nil)
                 
                 }
                 let activityController : UIActivityViewController
                 
                 let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]
                 let _: UIActivityViewController
                 
                 if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row]) {
                 
                 activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                 } else {
                 activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                 }
                 
                 self.present(activityController, animated: true, completion: nil)
                 completionHandler(true)
                 */
                
            }
            changePicButton.backgroundColor = UIColor(red:0.47, green:0.89, blue:0.37, alpha:1.0)
            
            return UISwipeActionsConfiguration(actions: [changePicButton])
    }
    
    func dialogBox(){
        
        let alert = UIAlertController(title: "Edit Name", message: "please enter a name you want", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter Text:"
            textField.isSecureTextEntry = false
            textField.delegate = self
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func camera()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    //相簿選擇
    func photoLibrary()
    {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    /*
     func showActionSheet() {
     
     let actionSheet = UIImagePickerController()
     
     actionSheet.delegate = self
     actionSheet.sourceType = UIImagePickerControllerSourceType.photoLibrary
     actionSheet.allowsEditing = false
     
     self.present(actionSheet, animated: true, completion: nil)
     
     }*/
    //頭像替換進入點？
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
           // restaurantImages[] = image
        }
        
        picker.dismiss(animated: true, completion: nil);
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing:" + textField.text!)
    }
}


