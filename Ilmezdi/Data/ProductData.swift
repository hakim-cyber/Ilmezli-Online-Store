//
//  ProductData.swift
//  Ilmezdi
//
//  Created by aplle on 7/7/23.
//

import SwiftUI
import CloudKit

@MainActor
class ProductsData:ObservableObject{
    @Published var exampleProducts:[Product] = []
    
    
    
    @Published var categories = [ Category(title: "Hamısı", image: "square.stack.3d.up"),
        Category(title: "Ev", image: "house.lodge.circle"),Category(title: "Mətbəx", image: "fork.knife"),Category(title: "Texnika", image: "desktopcomputer"),Category(title: "Tikinti", image: "building.2.crop.circle"),Category(title: "Xırdavat", image: "light.ribbon"),
                                  Category(title: "Idman", image: "dumbbell")
    ]
    
    private var db = CKContainer(identifier:"iCloud.com.hakimAliyev.ilmezdiCloud").publicCloudDatabase
    // boolean to show cartView
    @Published var showCartView = false
    @Published var subscribedToNotification = false
    
    init(){
        loadSubscribingBool()
    }
    func saveSubscribingBool(){
        UserDefaults.standard.set(subscribedToNotification, forKey: "subscribedToNotification")
    }
    func loadSubscribingBool(){
        
       let bool = UserDefaults.standard.bool(forKey: "subscribedToNotification")
        
        self.subscribedToNotification = bool
    }
    func useImage(text:String)->Image{
           let data = Data(base64Encoded: text) ?? Data()
           
           let uiImage = UIImage(data: data) ?? UIImage()
           
           return Image(uiImage: uiImage)
       }
    func deleteProduct(product:Product){
        if let id = exampleProducts.firstIndex(where: {$0.id == product.id}){
            
            if let recordId = exampleProducts[id].recordId{
                
                
                db.delete(withRecordID: recordId) { recordId, error in
                    guard error == nil else{
                        return
                    }
                    DispatchQueue.main.async {
                        self.exampleProducts.remove(at: id)
                    }
                   
                }
                
            }
        }
    }
    func addProduct(product:Product){
       
            exampleProducts.append(product)
        
    }
    
    func updateProduct(editedProduct:Product,completion:@escaping ()->Void) async throws{
        
        let record = try await  db.record(for: editedProduct.recordId!)
        
        record[ProductRecordKeys.category.rawValue] = editedProduct.category
        record[ProductRecordKeys.description.rawValue] = editedProduct.description
        record[ProductRecordKeys.id.rawValue] = editedProduct.id
        record[ProductRecordKeys.images.rawValue] = editedProduct.images
        record[ProductRecordKeys.name.rawValue] = editedProduct.name
        record[ProductRecordKeys.postDate.rawValue] = editedProduct.postDate
        record[ProductRecordKeys.price.rawValue] = editedProduct.price
       
        try await db.save(record)
        if let index = exampleProducts.firstIndex(where: {$0.id == editedProduct.id}){
            exampleProducts[index] = editedProduct
            completion()
        }
    }
    
    
    
    
    func addNewProduct(product:Product,completion:@escaping ()->Void)async throws{
       
            let record = try await db.save(product.record)
            guard let task = Product(record: record) else {return}
            DispatchQueue.main.async {
                self.exampleProducts.append(task)
            }
            completion()
            print("added")
      
    }
    func readProducts()async throws{
        let query = CKQuery(recordType: ProductRecordKeys.type.rawValue, predicate: NSPredicate(value: true))
        
        
        let result = try await db.records(matching: query)
        
      let records =  result.matchResults.compactMap{try? $0.1.get()}
        DispatchQueue.main.async { [self] in
        self.exampleProducts = []
            
            var allProductsSorted:[Product] = []
    
            records.forEach{record in
                let product = Product(record: record)
                if product != nil{
                    allProductsSorted.append(product!)
                }
            }
            self.exampleProducts = allProductsSorted.sorted{
                stringToDate(string: $0.postDate) > stringToDate(string: $1.postDate)
            }
        }
       
    }
   
    
    
    
    func stringToDate(string:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let reverseDate = dateFormatter.date(from: string)
        return reverseDate ?? Date.now
       
    }
    func dateToString(date:Date)->String{
        let dateFormatter = DateFormatter()

        // Convert Date to String
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    func imageToString(image:UIImage?,resize:Bool = true)->String{
        guard let image = image else {
            print("Error: Unable to get image or convert to data")
            return ""
        }
        if resize{
            
            let resizedImage = image.resize(to: CGSize(width: image.size.width / 5, height: image.size.height / 5)) // Adjust the desired size
            
            guard let resizedImageData = resizedImage!.jpegData(compressionQuality: 0.5) else {
                print("Error: Unable to resize image or convert to data")
                return ""
            }
            
            print(resizedImageData.count)
            let imageString = resizedImageData.base64EncodedString()
            
            return imageString
        }else{
            let imageString = (image.jpegData(compressionQuality: 1)?.base64EncodedString())!
            return imageString
        }
    }
    
    func requestNotificationPermissions(completion:@escaping (Bool)-> Void){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { bool, error in
            if let error =  error{
                print(error)
                completion(false)
            }else if bool{
                print("Succes")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    completion(true)
                }
                
               
            }else{
                print("failed for permission")
                completion(false)
            }
        }
    }
    func subscribeToNotifications(completion:@escaping (Bool)-> Void){
        let subscription = CKQuerySubscription(recordType: ProductRecordKeys.type.rawValue, predicate: NSPredicate(value: true),subscriptionID: "new_product_added",options: .firesOnRecordCreation)
        
        let notification = CKSubscription.NotificationInfo()
        
        notification.titleLocalizationKey = "🎉 %1$@ 🎉"
        notification.titleLocalizationArgs = ["name"]
        notification.soundName = "default"
        
        notification.alertLocalizationKey = "%1$@"
        notification.alertLocalizationArgs = ["description"]
    
        
        
        notification.shouldSendContentAvailable = true
        
    
        
        subscription.notificationInfo = notification
        
        db.save(subscription) { [self] returnedSubscription, error in
            
            if let error = error{
                print("Error subscribing \(error)")
                print("Error subscribing \(error)")
                
                completion(false)
               
            }else{
                print("Succesfully added")
                completion(true)
                
            }
        }
        
    }
}
   
import UIKit

extension UIImage {
    func resize(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
