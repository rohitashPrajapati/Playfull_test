//
//  OrderDetailRouter.swift
//  Playfull_test
//
//  Created by ISOL on 11/09/18.
//  Copyright (c) 2018 Example. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol OrderDetailRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol OrderDetailDataPassing
{
  var dataStore: OrderDetailDataStore? { get }
}

class OrderDetailRouter: NSObject, OrderDetailRoutingLogic, OrderDetailDataPassing
{
  weak var viewController: OrderDetailViewController?
  var dataStore: OrderDetailDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: OrderDetailViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: OrderDetailDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}