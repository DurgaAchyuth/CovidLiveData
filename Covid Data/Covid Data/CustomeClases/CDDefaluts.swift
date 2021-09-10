//
//  CDDefaluts.swift
//  Corona Data
//
//  Created by Achyuth Bujjigadu  on 05/09/21.
//

import UIKit

class CDDefaluts: NSObject {
    static var minutes: String = "0"
    static var savedCountryNames: Array = [String]()
    
    class func clearDefaluts() {
        CDDefaluts.savedCountryNames = []
    }
}
