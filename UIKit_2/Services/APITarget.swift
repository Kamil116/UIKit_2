//
//  APITarget.swift
//  UIKit_2
//
//  Created by Kamil on 10.07.2023.
//

import Moya

enum APITarget {
    case getCharacters
}

extension APITarget: Moya.TargetType {
    var sampleData: Data {
        return Data()
    }
    

    var baseURL: URL {
        guard let url = URL(string: "https://rickandmortyapi.com/api/") else {
            fatalError("Не можем получить юрл")
        }
        return url
    }

    var path: String {
        switch self {
        case .getCharacters:
            return "character/1,2,3,4,6"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Moya.Task {
        .requestParameters(parameters: [
            "status": "alive",
            "gender": "female"
        ], encoding: URLEncoding.default)
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json",
                "Cache-Control": "no-cache"]
    }
}
