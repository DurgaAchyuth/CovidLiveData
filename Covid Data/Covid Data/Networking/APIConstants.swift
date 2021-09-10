//
//  APIConstants.swift
//  Corona Data
//
//  Created by Achyuth Bujjigadu  on 04/09/21.
//

import Foundation

public enum ApiConstants {
    enum Internet {
        static let url = "https://www.google.com/"
    }

    enum ApiMethodsUrls {
        static let countries = "countries"
        static let reportByCountry = "live/country/"
    }

    enum APIParameterKey {
        static let language = "language"
    }
    
    enum DataShareingKeys {
        static var countryName = ""
    }
}

public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case xApiKey = "x-api-key"
}

public enum ContentType: String {
    case json = "application/json"
}
