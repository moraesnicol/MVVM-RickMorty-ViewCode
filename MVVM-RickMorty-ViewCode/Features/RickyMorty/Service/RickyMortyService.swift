//
//  RickyMortyService.swift
//  MVVM-RickMorty-ViewCode
//
//  Created by Gabriel on 06/09/21.
//

import Alamofire

enum RickyMortyServiceEndPoint: String {
    
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickyMortyService {
    func fetchAllData(response: @escaping ([Result]?) -> Void )
}


struct RickyMortyService: IRickyMortyService {

    
    
    func fetchAllData(response: @escaping ([Result]?) -> Void) {
        AF.request(RickyMortyServiceEndPoint.characterPath()).responseDecodable(of: PostModel.self)  {
            (model) in
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.results)
            print(response)
        }
    }
}
