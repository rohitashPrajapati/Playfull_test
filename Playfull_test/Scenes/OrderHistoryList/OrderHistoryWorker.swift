//
//  OrderHistoryWorker.swift
//  Playfull_test
//
//  Created by ISOL on 10/09/18.
//  Copyright (c) 2018 Example. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit


protocol OrderHistoryWorkerDelegate
{
//    func listGistsWorker(listGistsWorker: ListGistsWorker, didFetchGists gists: [Gist])
    
    func orderHistoryWorker(orderHistoryWorker: OrderHistoryWorker,didFetchOrders orders:[Order])
    func orderHistoryWorker(orderHistoryWorker: OrderHistoryWorker,didFailedToFetchOrders message: String)
}


class OrderHistoryWorker
{
  var delegate: OrderHistoryWorkerDelegate?
    
  func fetchOrder()
  {
    OrdersWorker.shared.fetchOrders(onSuccess: { (orders) in
        self.delegate?.orderHistoryWorker(orderHistoryWorker: self, didFetchOrders: orders)
    }) { (message) in
        self.delegate?.orderHistoryWorker(orderHistoryWorker: self, didFailedToFetchOrders: message ?? "")
    }
    
  }
}
