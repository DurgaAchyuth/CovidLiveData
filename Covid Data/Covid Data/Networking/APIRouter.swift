//
//  APIRouter.swift
//  Corona Data
//
//  Created by Achyuth Bujjigadu  on 04/09/21.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    case countryNamesList
    case getReportByCountry
    
    // MARK: - HTTPMethod

    private var method: HTTPMethod {
        switch self {
        case .countryNamesList:
            return .get
        case .getReportByCountry:
            return .get
        }
    }
    
    // MARK: - Path

    private var path: String {
        switch self {
        case .countryNamesList:
            return ApiConstants.ApiMethodsUrls.countries
        case .getReportByCountry:
            let pathStr = ApiConstants.ApiMethodsUrls.reportByCountry + ApiConstants.DataShareingKeys.countryName
            return pathStr
        }
    }
    
    // MARK: - Parameters

    private var parameters: Parameters? {
        switch self {
        case .countryNamesList:
            return .none
        case .getReportByCountry:
            return .none
        }
    }

    // MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try Enviroment.current.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Parameters
        if let parameters = parameters {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                let jsonString = String(decoding: jsonData, as: UTF8.self)
                print(jsonString)
                urlRequest.httpBody = jsonData

            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        } else {
            urlRequest.httpBody = nil
        }
        return urlRequest
    }
}
