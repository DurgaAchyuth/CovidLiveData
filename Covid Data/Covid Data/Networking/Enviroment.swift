//
//  Enviroment.swift
//  Corona Data
//
//  Created by Achyuth Bujjigadu  on 04/09/21.
//

import Foundation

protocol EnviromentType {
    var baseURL: String { get }
}

enum Enviroment {
    static let current = Develop()

    struct Develop: EnviromentType {
        //  use https
        var baseURL: String { "https://api.covid19api.com/" }
    }
}
