//
//  ProfileService.swift
//  LinkinBio
//
//  Created by Paul Huynh on 2021-02-20.
//  Copyright © 2021 Ian MacKinnon. All rights reserved.
//

import Foundation
import Alamofire

class ProfileService {

    func retrieve<T: Codable>(urlString: String, success: @escaping ((T) -> Void), failure: @escaping ((NetworkError) -> Void)) {
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Authorization": ""]).responseJSON { response in

            switch response.result {
            case .success:
                guard let data = response.data else {
                    DispatchQueue.main.async {
                        failure(.noData)
                    }
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let object = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        success(object)
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure(.error(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    failure(.error(error))
                }
            }
        }
    }
}


enum NetworkError: Error {
    case error(Error)
    case noData
}
