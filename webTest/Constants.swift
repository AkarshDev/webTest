//
//  Constants.swift
//  webTest
//
//  Created by Akarsh Ram on 16/07/22.
//


import UIKit
import SwiftLoader
import TTGSnackbar


class Constant: UIViewController
{
 
    let error_msg = "Something went wrong, Please try again..."
    let baseUrl = "https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0"
    let deviceType = "ios"
    var deviceID  = "123456"


    private static let _sharedInstance = Constant()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Class function
    
    class func sharedInstance() -> Constant
    {
        return _sharedInstance
    }
    func show_snak_with_text(text:NSString)
    {
        let snackbar = TTGSnackbar(message:text as String, duration: .middle)
        snackbar.show()
    }
    func showLoader()
    {
        SwiftLoader.show(animated: true)
        SwiftLoader.show(title: "Loading...", animated: true)

    }
    func dismissLoader()
    {
        SwiftLoader.hide()

    }
}

