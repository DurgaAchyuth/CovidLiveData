//
//  APIClient.swift
//  Corona Data
//
//  Created by Achyuth Bujjigadu  on 04/09/21.
//

import Alamofire

enum APIError: Error {
    case noData
    case parsingError
}

enum APIClient {
    
    private static let session: Session = {
      let configuration = URLSessionConfiguration.af.default
      configuration.timeoutIntervalForRequest = 30
      return Session(configuration: configuration)
        
    }()

    static func isNetworkReachable() -> Bool {
        let manager = NetworkReachabilityManager(host: ApiConstants.Internet.url)
        return manager?.isReachable ?? false
    }

    static func getCountryNames(completion: @escaping (Result<[CountrysList], APIError>) -> Void) {
        session.request(APIRouter.countryNamesList).responseJSON { response in
            guard case .success = response.result, response.response?.statusCode == 200 else {
                return
            }
            guard let data = response.data,
                  let apiResposne = try? JSONDecoder().decode([CountrysList].self, from: data)
            else {
                return completion(.failure(.parsingError))
            }
            if let token = apiResposne as [CountrysList]? {
                completion(.success(token))
            } else {
                completion(.failure(.noData))
            }
        }
    }
    
    static func getReportBtCountry(completion: @escaping (Result<[CountryReport], APIError>) -> Void) {
        session.request(APIRouter.getReportByCountry).responseJSON { response in
            guard case .success = response.result, response.response?.statusCode == 200 else {
                return
            }
            //let json = try? JSONSerialization.jsonObject(with: response.data!, options: [])
            guard let data = response.data,
                  let apiResposne = try? JSONDecoder().decode([CountryReport].self, from: data)
            else {
                return completion(.failure(.parsingError))
            }
            if let token = apiResposne as [CountryReport]? {
                completion(.success(token))
            } else {
                completion(.failure(.noData))
            }
        }
    }
  
}

