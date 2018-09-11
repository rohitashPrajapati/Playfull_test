//
//  Order.swift
//  Playfull_test
//
//  Created by ISOL on 10/09/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation

struct Order {
    var status: String?
    var reward: String?
    var details: OrderDetails?
    var restaurant: Restaurant?
    var uuid: String?
    var pickedUpAt: String?
    var fulfillmentType: String?
}


struct OrderDetails {
    var items: [Item]?
    var taxAmount: Float?
    var subtotal: Float?
    var tipAmount: Float?
    var uuid: String?
    var totalAmount: Float?
    var spendAmount: Float?
    var discountAmount: Float?
    var serviceFeeAmount: Float?
}

struct Item {
    var upsellId: Int?
    var selectedOptionsDescription: String?
    var quantity: Int?
    var specialInstructions: String?
    var name: String?
    var priceAmount: Float?
}

struct Restaurant {
    var hours: String?
    var city: String?
    var imageUrl: String?
    var streetAddress2: String?
    var state: String?
    var id: Int?
    var zipCode: Int?
    var longitude: Float?
    var streetAddress: String?
    var address: String?
    var latitude: Float?
    var name: String?
    var openState: String?
    var phoneNumber: String?
}
