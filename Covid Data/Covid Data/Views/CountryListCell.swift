//
//  CountryListCell.swift
//  Corona Data
//
//  Created by Achyuth Bujjigadu  on 04/09/21.
//

import UIKit

public protocol Reuseable {
    static func reuseID() -> String
}

class CountryListCell: UITableViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension CountryListCell: Reuseable {
    static func reuseID() -> String {
        return String(describing: self)
    }
}
