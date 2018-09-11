//
//  Constants.swift
//  Playfull_test
//
//  Created by ISOL on 10/09/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import Foundation


let API_URL = "https://4n5es1emed.execute-api.us-west-2.amazonaws.com/playfull/orders"

let STATUS = ["C":"Picked up", "R":"Ready For Pick Up", "S":"In Preparation"]

// Restaurant open_status Representation strings
let OPEN_STRING = "● Open Now"
let CLOSED_STRING = "● Closed"
let OPEN_STATUS_COLOR = UIColor(red: 0/255.0, green: 200/255.0, blue: 0/255.0, alpha: 1.0)
let CLOSED_STATUS_COLOR = UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
