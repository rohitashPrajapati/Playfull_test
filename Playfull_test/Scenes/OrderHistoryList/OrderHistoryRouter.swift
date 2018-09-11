//
//  OrderHistoryRouter.swift
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


@objc protocol OrderHistoryRoutingLogic
{
    func routeToOrderDetailWithSegue(segue: UIStoryboardSegue?)
}

protocol OrderHistoryDataPassing
{
  var dataStore: OrderHistoryDataStore? { get }
}

class OrderHistoryRouter: NSObject, OrderHistoryRoutingLogic, OrderHistoryDataPassing
{
  weak var viewController: OrderHistoryViewController?
  var dataStore: OrderHistoryDataStore?
  
  // MARK: Routing
  
    func routeToOrderDetailWithSegue(segue: UIStoryboardSegue?)
    {
        if let segue = segue {
            if let destinationVC = segue.destination as? OrderDetailViewController {
                var destinationDS = destinationVC.router!.dataStore!
                passDataToOrderDetail(source: dataStore!, destination: &destinationDS )
            }
        } else {
            if let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "OrderDetailViewController") as? OrderDetailViewController {
                var destinationDS = destinationVC.router!.dataStore!
                passDataToOrderDetail(source: dataStore!, destination: &destinationDS)
                navigateToOrderDetail(source: viewController!, destination: destinationVC)
            }

        }
    }

  // MARK: Navigation
  
  func navigateToOrderDetail(source: OrderHistoryViewController, destination: OrderDetailViewController)
  {
        source.show(destination, sender: nil)
  }
  
 // MARK: Passing data
  
    func passDataToOrderDetail(source: OrderHistoryDataStore, destination: inout OrderDetailDataStore)
    {
        let selectedRow = viewController?.tblView.indexPathForSelectedRow?.row
        destination.orderFullData = source.ordersFullData?[selectedRow!]
    }
}
