//
//  OrderHistoryViewController.swift
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

protocol OrderHistoryDisplayLogic: class
{
    func displayOrderHistoryData(viewModel: OrderHistory.FetchOrders.ViewModel)
    func displayFailureMessage(message: String)
}

class OrderHistoryTableViewCell : UITableViewCell
{
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblOpenStatus: UILabel!
}

class OrderHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, OrderHistoryDisplayLogic
{
    
    @IBOutlet weak var tblView: UITableView!
    
  var interactor: OrderHistoryBusinessLogic?
  var router: (NSObjectProtocol & OrderHistoryRoutingLogic & OrderHistoryDataPassing)?
  var displayedOrders: [OrderHistory.FetchOrders.ViewModel.OrderDisplayData] = []
  

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = OrderHistoryInteractor()
    let presenter = OrderHistoryPresenter()
    let router = OrderHistoryRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
        let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        CommonFunctions.showViewBaseActivityIndicator(baseView: self.view)
        fetchOrderHistory()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(displayedOrders.count > 0) {
            tblView.reloadData()
        }
    }
  
  
  // MARK: Fetch data from server for listing of Order History
  
    func fetchOrderHistory() {
        let request = OrderHistory.FetchOrders.Request()
        interactor?.fetchOrders(request: request)
    }
    
    
    // MARK: OrderHistoryDisplayLogic protocol methods
  
    // Called when get orders history listing data
    func displayOrderHistoryData(viewModel: OrderHistory.FetchOrders.ViewModel) {
        DispatchQueue.main.async {
            self.displayedOrders = viewModel.ordersDataAry
            CommonFunctions.hideViewBaseActivityIndicator()
            self.tblView.reloadData()
        }
    }
    
    // Called when failed to get the orders history listing data
    func displayFailureMessage(message: String) {
      print("displayFailureMessage")
    }
    
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedOrders.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = displayedOrders[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryTableViewCell") as? OrderHistoryTableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "OrderHistoryTableViewCell") as? OrderHistoryTableViewCell
        }
        
        // Set round corners to the view
        CommonFunctions.setRoundCornerOfView(view: cell?.cardView)
        CommonFunctions.setRoundCornerOfView(view: cell?.imgView)
        
        // Set shadow effect to the view
        CommonFunctions.setShadowToTheView(view: (cell?.cardView)!, scale: true)
        
        cell?.lblRestaurantName.text = order.restaurantName
        cell?.lblTotalAmount.text =  order.total
        cell?.lblOrderDate.text = order.orderDate
        cell?.lblStatus.text = order.status
        cell?.lblOpenStatus.text = order.openStatus
        
        // Set restaurant open_status label color according to status
        if(order.openStatus == OPEN_STRING) {
            cell?.lblOpenStatus.textColor = OPEN_STATUS_COLOR
        } else {
            cell?.lblOpenStatus.textColor = CLOSED_STATUS_COLOR
        }
        
        // Download image for restaurant Logo
        if(order.restaurantLogo != nil){
            downloadImageFromTheServerAndSetToCell(imageUrl: order.restaurantLogo!, indexPath: indexPath)
        } else {
            cell?.imgView.image = UIImage(named: "placeholder")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToOrderDetailWithSegue(segue: nil)
    }
    
    // Download image for restaurant logo asynchronously, This function will download and update the image in the tableView cell.
    func downloadImageFromTheServerAndSetToCell(imageUrl : String ,indexPath : IndexPath)
    {
        CommonFunctions.getDownloadImage(imageUrl: imageUrl, onSuccess: { (imgData) in
            DispatchQueue.main.async() {
                if let cell = self.tblView.cellForRow(at: indexPath) as? OrderHistoryTableViewCell {
                    cell.imgView.image = imgData
                }
            }
        }) { (message) in
            print(message!)
        }
    }
    
}