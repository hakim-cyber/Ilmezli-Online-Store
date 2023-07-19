//
//  structs.swift
//  Ilmezdi
//
//  Created by aplle on 7/6/23.
//

import Foundation
import CloudKit
enum ProductRecordKeys:String{
    case type = "Product"
    case id
    case name
    case description
    case images
    case category
    case price
    case postDate
    
    
}

struct Product:Identifiable{
    let id:String
    var recordId:CKRecord.ID?
    
    let name:String
    let description:String
    
    let images:[String]
    
    let category:String
    var price:Double
    
    var postDate:String
  
    
   
}
extension Product{
    init?(record:CKRecord){
        guard let id =  record[ProductRecordKeys.id.rawValue] as? String,
              let name = record[ ProductRecordKeys.name.rawValue] as? String,
                let description = record[ ProductRecordKeys.description.rawValue] as? String,
              let images =   record[ ProductRecordKeys.images.rawValue] as? [String],
              let category =   record[ ProductRecordKeys.category.rawValue] as? String,
                let price =   record[ ProductRecordKeys.price.rawValue] as? Double,
              let postDate =  record[ ProductRecordKeys.postDate.rawValue] as? String else{
            return nil
        }
        self.init(id: id,recordId: record.recordID , name: name, description: description, images: images, category: category, price: price, postDate: postDate)
                
    }
}

extension Product{
    var record:CKRecord{
        let record = CKRecord(recordType: ProductRecordKeys.type.rawValue)
        
        record[ProductRecordKeys.id.rawValue] = id
        record[ ProductRecordKeys.name.rawValue] = name
        record[ ProductRecordKeys.description.rawValue] = description
        record[ ProductRecordKeys.images.rawValue] = images
        record[ ProductRecordKeys.category.rawValue] = category
        record[ ProductRecordKeys.price.rawValue] = price
        record[ ProductRecordKeys.postDate.rawValue] = postDate
        
        return record
    }
}

struct Category:Hashable{
    let title:String
    let image:String
}

struct CartItem:Identifiable{
    let id: UUID
    var product:Product
    var count = 1
}


@propertyWrapper
struct CustomStorage<T:Codable>{
   
    private let key:String
    private let defaultValue:T
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    var wrappedValue: T{
        get{
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else{
                return defaultValue
            }
            if let decoded = try? JSONDecoder().decode(T.self, from: data){
                return decoded
            }else{
                return defaultValue
            }
        }
        set{
            if let encoded = try? JSONEncoder().encode(newValue){
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}
