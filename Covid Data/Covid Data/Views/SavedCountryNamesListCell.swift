//
//  SavedCountryNamesListCell.swift
//  Corona Data
//
//  Created by Achyuth Bujjigadu  on 05/09/21.
//

import UIKit

class SavedCountryNamesListCell: UICollectionViewCell {
   
    @IBOutlet var nameLabel: UILabel!
}

extension SavedCountryNamesListCell: Reuseable {
    static func reuseID() -> String {
        return String(describing: self)
    }
}
