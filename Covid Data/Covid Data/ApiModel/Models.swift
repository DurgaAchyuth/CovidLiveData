//
//  Models.swift
//  Corona Data
//
//  Created by Achyuth Bujjigadu  on 04/09/21.
//

import Foundation

struct CountrysList: Codable {
    let country, slug, iso2: String

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case slug = "Slug"
        case iso2 = "ISO2"
    }
}

struct CountryReport: Codable {
    let country, countryCode, lat, lon: String
    let confirmed, deaths, recovered, active: Int
    let date: String
    let locationID: String
    let city, cityCode, province: String

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case lat = "Lat"
        case lon = "Lon"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
        case locationID = "ID"
        case city = "City"
        case cityCode = "CityCode"
        case province = "Province"
    }
}
