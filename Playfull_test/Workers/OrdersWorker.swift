//
//  OrdersWorker.swift
//  Playfull_test
//
//  Created by ISOL on 10/09/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation

class OrdersWorker {
    
    static let shared = OrdersWorker()

    
    func fetchOrders(onSuccess success:@escaping ([Order]) -> Void, onFailure failure:@escaping (_ message: String?) -> Void ){
        
        let url = URL(string: API_URL)!

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if(error != nil) {
                failure(error?.localizedDescription ?? "Error in fetching Orders.")
                return
            }
            
            // You can print out response object
            print("response = \(String(describing: response))")
            
            //Let's convert response sent from a server side script to Orders Array object:
            do {
                if(data != nil){
                    guard let json = try JSONSerialization.jsonObject(with: data!) as? [[String: Any]] else {
                        failure("Failed to get orders data!")
                        return
                    }
                    print(json)
                    let ordersAry = self.parseJSONToOrders(json: json)
                    success(ordersAry)
                }
            } catch {
                
                failure("Failed to get orders data from api!")
                print(error)
            }
        }
        task.resume()
    }
    
    private func parseJSONToOrders(json: Any) -> [Order] {
        
        var ordersAry = [Order]()
        
        if let dataAry = json as? [Any] {
            for order in dataAry {
                
                if let order = order as? [String:Any] {
                    
                    let status = order["status"] as? String
                    let reward = order["reward"] as? String
                    let uuid = order["uuid"] as? String
                    let pickedUpAt = order["picked_up_at"] as? String
                    let fulfillmentType = order["fulfillment_type"] as? String
                    var orderDetails: OrderDetails?
                    var restaurantDetails: Restaurant?
                    
                    if let details = order["details"] as? [String:Any] {
                        
                        var itemsAry = [Item]()
                        if let items = details["items"] as? [Any] {
                            for item in items {
                                if let itemData = item as? [String:Any] {
                                    if let item = itemData["item"] as? [String:Any] {
                                        let upsellId = item["upsell_id"] as? Int
                                        let selectedOptionsDescription = item["selected_options_description"] as? String
                                        let quantity = item["quantity"] as? Int
                                        let specialInstructions = item["special_instructions"] as? String
                                        let name = item["name"] as? String
                                        let priceAmount = item["price_amount"] as? Float
                                        
                                        let itemData = Item(upsellId: upsellId, selectedOptionsDescription: selectedOptionsDescription, quantity: quantity, specialInstructions:specialInstructions, name: name, priceAmount: priceAmount)
                                        itemsAry.append(itemData)
                                    }
                                }
                            }
                        }
                        
                        let taxAmount = details["tax_amount"] as? Float
                        let subtotal = details["subtotal"] as? Float
                        let tipAmount = details["tip_amount"] as? Float
                        let uuid = details ["uuid"] as? String
                        let totalAmount = details["total_amount"] as? Float
                        let spendAmount = details["spend_amount"] as? Float
                        let discountAmount = details["discount_amount"] as? Float
                        let serviceFeeAmount = details["service_fee_amount"] as? Float
                        
                        orderDetails = OrderDetails(items: itemsAry, taxAmount: taxAmount, subtotal: subtotal, tipAmount: tipAmount, uuid: uuid, totalAmount: totalAmount, spendAmount: spendAmount, discountAmount: discountAmount, serviceFeeAmount: serviceFeeAmount)
                    }
                    
                    if let restaurant = order["restaurant"] as? [String:Any] {
                        
                        let hours = restaurant["hours"] as? String
                        let city = restaurant["city"] as? String
                        let imageUrl = restaurant["image_url"] as? String
                        let streetAddress2 = restaurant["street_address2"] as? String
                        let state = restaurant["state"] as? String
                        let id = restaurant["id"] as? Int
                        let zipCode = restaurant["zip_code"] as? Int
                        let longitude = restaurant["longitude"] as? Float
                        let streetAddress = restaurant["street_address"] as? String
                        let address = restaurant["address"] as? String
                        let latitude = restaurant["latitude"] as? Float
                        let name = restaurant["name"] as? String
                        let openState = restaurant["open_state"] as? String
                        let phoneNumber = restaurant["phone_number"] as? String
                        
                        restaurantDetails = Restaurant(hours: hours, city: city, imageUrl: imageUrl, streetAddress2: streetAddress2, state: state, id: id, zipCode: zipCode, longitude: longitude, streetAddress: streetAddress, address: address, latitude: latitude, name: name, openState: openState, phoneNumber: phoneNumber)
                    }
                    
                    let orderData = Order(status: status, reward: reward, details: orderDetails, restaurant: restaurantDetails, uuid: uuid, pickedUpAt: pickedUpAt, fulfillmentType: fulfillmentType)
                    
                    ordersAry.append(orderData)
                    
                }
            }
        }
        return ordersAry
    }
    
    
}
