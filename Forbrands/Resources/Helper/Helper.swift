//
//  Helper.swift
//  Forbrands
//
//  Created by osamaaassi on 21/08/2021.
//

import Foundation
import UIKit

class Helper: NSObject {
    class func quit() {
            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            //Comment if you want to minimise app
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                exit(0)
            }
        }
    
    
}
