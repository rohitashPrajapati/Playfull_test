//
//  OrderDetailPresenter.swift
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

protocol OrderDetailPresentationLogic
{
  func presentOrderDetails(response: OrderDetail.GetOrderDetails.Response)
  func failedToGetOrderDetails(message: String)
}

class OrderDetailPresenter: OrderDetailPresentationLogic
{
  weak var viewController: OrderDetailDisplayLogic?
  
    
    
  // MARK: OrderDetailPresentationLogic methods
  
    // Called when got data from the interactor of scene
    func presentOrderDetails(response: OrderDetail.GetOrderDetails.Response)
    {
        let viewModel = getViewModelFromResponse(response: response)
        viewController?.displayOrderDetails(viewModel: viewModel)
    }
    
    // Called when failed to get data from the interactor of scene
    func failedToGetOrderDetails(message: String) {
        viewController?.failedToGetOrderDetails(message: message)
    }
    
    
  // MARK: Get view model data
    
    func getViewModelFromResponse(response: OrderDetail.GetOrderDetails.Response) -> OrderDetail.GetOrderDetails.ViewModel
    {
        let order = response.order
        let restaurantName = order?.restaurant?.name
        let restaurantLogo = order?.restaurant?.imageUrl
        let orderDate = CommonFunctions.convertDateFormatter(dateStr: order?.pickedUpAt)
        let status = STATUS[(order?.status!)!] ?? ""
        let totalAmount = CommonFunctions.priceFormater(price: order?.details?.totalAmount)
        let openStatus = CommonFunctions.openStatusForStatusString(status: order?.restaurant?.openState)
        let taxAmount = CommonFunctions.priceFormater(price: order?.details?.taxAmount)
        let items = order?.details?.items
        var itemsData = [OrderDetail.GetOrderDetails.ViewModel.ItemDetail]()
        for item in items! {
            let name = item.name
            let selectedOptionsDescription = item.selectedOptionsDescription
            let quantity = String(item.quantity ?? 0)
            let priceAmount = CommonFunctions.priceFormater(price: item.priceAmount)
            let itemDetail = OrderDetail.GetOrderDetails.ViewModel.ItemDetail(name: name, selectedOptionsDescription: selectedOptionsDescription, quantity: quantity, priceAmount: priceAmount)
            itemsData.append(itemDetail)
        }
        let orderUUID = order?.details?.uuid ?? ""
        let viewModel = OrderDetail.GetOrderDetails.ViewModel(restaurantName: restaurantName, restaurantLogo: restaurantLogo, orderDate: orderDate, status: status, total: totalAmount, openStatus: openStatus, taxAmount: taxAmount, items: itemsData, orderUUID: orderUUID)
        return viewModel
    }
    
    
}