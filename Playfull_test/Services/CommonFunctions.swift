//
//  CommonFunctions.swift
//  Playfull_test
//
//  Created by ISOL on 10/09/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import Foundation


class CommonFunctions: NSObject {
    
    static let shared = CommonFunctions()
    
    static var viewBaseActivityIndicatorView: UIView?
    static var viewBaseActivityIndicator:UIActivityIndicatorView?
    
    // Download the image from the url and return the imagedata into the success callback , if false return error message in failure block
    static  func getDownloadImage(imageUrl : String, onSuccess  success:@escaping ( _ response : UIImage?) -> Void ,onFailure failure:@escaping (_ message :String?) -> Void){
        
        let url : URL! = URL(string: imageUrl)
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                    failure("Failed to Download Image")
                    return
            }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            print("data is this",data)
            let imge : UIImage? = UIImage(data: data)
            success(imge)
            
            }.resume()
    }
    
    //MARK:- ViewBase activity indicator
    
    static func showViewBaseActivityIndicator(baseView : UIView) {
        if((viewBaseActivityIndicatorView) == nil) {
            viewBaseActivityIndicatorView = UIView(frame: CGRect(x: 0, y: 0, width: baseView.bounds.width, height: baseView.bounds.height))
            viewBaseActivityIndicatorView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            viewBaseActivityIndicator = UIActivityIndicatorView()
            viewBaseActivityIndicator?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            viewBaseActivityIndicator?.center = (self.viewBaseActivityIndicatorView?.center)!
            viewBaseActivityIndicator?.hidesWhenStopped = true
            viewBaseActivityIndicator?.activityIndicatorViewStyle =
                UIActivityIndicatorViewStyle.whiteLarge
            self.viewBaseActivityIndicatorView?.addSubview(viewBaseActivityIndicator!)
            viewBaseActivityIndicator?.startAnimating()
            baseView.addSubview(viewBaseActivityIndicatorView!)
        }
    }
    
    // Hide the Overlay Activity indicator
    static func hideViewBaseActivityIndicator()
    {
        if((viewBaseActivityIndicatorView) != nil)
        {
            viewBaseActivityIndicator?.removeFromSuperview()
            viewBaseActivityIndicatorView?.removeFromSuperview()
            viewBaseActivityIndicator = nil
            viewBaseActivityIndicatorView = nil
        }
    }
    
    // MARK: Date formater to MM/dd/yyyy
    
    static func convertDateFormatter(dateStr: String?) -> String {
        
        if(dateStr != nil) {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from: dateStr!)
        
            dateFormatter.dateFormat = "MM/dd/yyyy"///this is what you want to convert format
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
            let timeStamp = dateFormatter.string(from: date!)
            return timeStamp
            
        } else {
            return ""
        }
    }
    
    // MARK: price Formater ex. $7.56
    
    static func priceFormater(price: Float?) -> String {
        if(price != nil) {
            let dollarPrice = price!/100;
            let priceStr = String(format:"$%.2f", dollarPrice)
            return priceStr
        } else {
            return ""
        }
    }
    
    // MARK: Open-Close status of the restaurant
    
    static func openStatusForStatusString(status: String?) -> String {
        if(status != nil) {
            if(status == "open") {
                return OPEN_STRING
            } else {
                return CLOSED_STRING
            }
        } else {
            return ""
        }
    }
    
    // Round the corner of the view
    static func setRoundCornerOfView(view: UIView?){
        if(view != nil){
            view?.layer.cornerRadius = 10
            view?.clipsToBounds = true
        }
    }
    
    // Set shadow effect to the view
    static func setShadowToTheView(view: UIView,scale: Bool = true) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 5
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    
    
}
