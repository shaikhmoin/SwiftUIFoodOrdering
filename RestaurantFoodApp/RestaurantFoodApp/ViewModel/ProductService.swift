//
//  ProductService.swift
//  RestaurantFoodApp
//
//  Created by macOS on 08/09/23.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FoodProduct: Codable, Identifiable {
    @DocumentID var id: String?
    var categoryID: String
    var categoryName: String
    var name: String
    var description: String
    var price: Double
    var imageURL: String
}

class ProductService: ObservableObject {
    private let db = Firestore.firestore()
    
    func addProduct(product: FoodProduct) {
        do {
            _ = try db.collection("Products").addDocument(from: product)
        } catch {
            print("Error adding product: \(error)")
        }
    }
    
    func getProductsByCategory(categoryID: String, completion: @escaping ([FoodProduct]) -> Void) {
        db.collection("Products")
            .whereField("categoryID", isEqualTo: categoryID)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting products: \(error)")
                    completion([])
                } else {
                    var products = [FoodProduct]()
                    for document in querySnapshot!.documents {
                        if let product = try? document.data(as: FoodProduct.self) {
                            products.append(product)
                        }
                    }
                    completion(products)
                }
            }
    }
}
