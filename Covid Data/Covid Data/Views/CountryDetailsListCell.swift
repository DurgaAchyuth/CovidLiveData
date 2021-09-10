//
//  CountryDetailsListCell.swift
//  Corona Data
//
//  Created by Achyuth Bujjigadu  on 04/09/21.
//

import UIKit

class CountryDetailsListCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var recorvedLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
extension CountryDetailsListCell: Reuseable {
    static func reuseID() -> String {
        return String(describing: self)
    }
}
