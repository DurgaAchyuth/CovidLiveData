//
//  CountrysListVC.swift
//  Corona Data
//
//  Created by Achyuth Bujjigadu  on 04/09/21.
//

import UIKit
import Alamofire

class CountrysListVC: UIViewController {
    
    @IBOutlet var countryListsTabelView: UITableView!
    @IBOutlet weak var countrySearchbar: UISearchBar!
    @IBOutlet var namesCollectionview: UICollectionView!
    @IBOutlet var heightForCollectionview: NSLayoutConstraint!
    @IBOutlet var heightForTitle: NSLayoutConstraint!
    
    var countryListArray = [CountrysList]()
    var searchedList: [CountrysList] = []
    var fetchedCountryNames = [String]() {
        didSet {
            namesCollectionview.reloadData()
        }
    }
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countrySearchbar.delegate = self
        callCountryLists()
        startPreloader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchedCountryNames = IMUtility.retrieveData()
        showSavedData()
    }
    
    func callCountryLists() {
        APIClient.getCountryNames() { [self] result in
            stopPreloder()
            switch result {
            case .success(let response):
                if !response.isEmpty {
                    countryListArray = response
                } else {
                    IMUtility.showAlert(sender: self, title: "App Title Name", message: "No data found..!")
                }

                DispatchQueue.main.async {
                    countryListsTabelView.reloadData()
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
    
    func showSavedData() {
        if !fetchedCountryNames.isEmpty {
            heightForCollectionview.constant = 60
            heightForTitle.constant = 21
            namesCollectionview.reloadData()
        } else{
            heightForTitle.constant = 0
            heightForCollectionview.constant = 0
        }
    }
}




extension CountrysListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if searching {
            return searchedList.count
        } else {
            return countryListArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryListCell.reuseID(), for: indexPath) as? CountryListCell
        if searching {
            let country = searchedList[indexPath.row]
            cell?.countryNameLabel.text = country.country
        } else {
            let country = countryListArray[indexPath.row]
            cell?.countryNameLabel.text = country.country
        }
        cell!.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsVC = storyBoard.instantiateViewController(withIdentifier: "CountryDetailsVC") as? CountryDetailsVC else { return }
        ApiConstants.DataShareingKeys.countryName = ""
        if searching {
            detailsVC.selectedCountry = searchedList[indexPath.row].country
        } else {
            detailsVC.selectedCountry = countryListArray[indexPath.row].country
        }
        navigationController?.pushViewController(detailsVC, animated: false)
    }
}

extension CountrysListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchedList.removeAll()
            searchedList = countryListArray.filter {
                return $0.country.range(of: searchText, options: .caseInsensitive) != nil
            }
            searching = true
        } else {
            searching = false
            searchBar.text = ""
        }
        countryListsTabelView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        countrySearchbar.searchTextField.endEditing(true)
        countryListsTabelView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchBar.text))")
        countrySearchbar.searchTextField.endEditing(true)
    }
}

extension CountrysListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return fetchedCountryNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedCountryNamesListCell",
                                                      for: indexPath) as? SavedCountryNamesListCell
        let namesList = fetchedCountryNames[indexPath.row]
        cell!.nameLabel.text = namesList
        return cell!
    }
    
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedName = fetchedCountryNames[indexPath.row]
        let status = IMUtility.deleteData(selectedName: selectedName)
        if status {
            fetchedCountryNames = IMUtility.retrieveData()
            showSavedData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16) / 2
        return CGSize(width: width, height: width)
    }

    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}
