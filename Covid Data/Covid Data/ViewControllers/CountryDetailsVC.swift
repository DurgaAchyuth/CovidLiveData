//
//  CountryDetailsVC.swift
//  Corona Data
//
//  Created by Achyuth Bujjigadu  on 04/09/21.
//

import UIKit

class CountryDetailsVC: UIViewController {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet var countryDetailsTabelView: UITableView!
    var countryDetailsListArray = [CountryReport]()
    var selectedCountry = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryNameLabel.text = selectedCountry
        let countryName:String = selectedCountry.replacingOccurrences(of: " ", with: "-")
        ApiConstants.DataShareingKeys.countryName = countryName
        startPreloader()
        callReportByCountryName()
        IMUtility.saveCountryName(saveData: selectedCountry)
        
    }
    
    func callReportByCountryName() {
        APIClient.getReportBtCountry() { [self] result in
            stopPreloder()
            switch result {
            case .success(let response):
                if !response.isEmpty {
                    countryDetailsListArray = response
                } else {
                    IMUtility.showAlert(sender: self, title: "App Title Name", message: "No data found for your selection..!")
                }
                countryDetailsListArray.sort(by: { $0.date.compare($1.date) == .orderedDescending })
                DispatchQueue.main.async {
                    countryDetailsTabelView.reloadData()
                }
            case let .failure(error):
                if error == APIError.parsingError {
                    print("Parsing Error")
                }  else if error == APIError.noData {
                    print("No Data...!")
                } else {
                    print("Un Know Error...!")
                }
            }
        }
    }
}

extension CountryDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        countryDetailsListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryDetailsListCell.reuseID(), for: indexPath) as? CountryDetailsListCell
        let details = countryDetailsListArray[indexPath.row]
        let date = IMUtility.convertDate(dateString: details.date)
        cell?.dateLabel.text = date
        cell?.activeLabel.text = String(details.active)
        cell?.recorvedLabel.text = String(details.recovered)
        cell?.deathsLabel.text = String(details.deaths)
        cell?.confirmedLabel.text = String(details.confirmed)
        return cell!
    }
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
