//
//  NetworkServiceManager.swift
//  kinopoisk
//
//  Created by mac on 16.03.22.
//

import Foundation
import Alamofire

class NetworkServiceManager {
    static let shared = NetworkServiceManager()

    private let headers = HTTPHeaders(["X-API-KEY" : API.APIToken.rawValue])
    private func getResult<T: Decodable>(with result: Result<T, AFError>,
                                         onSuccessResult: @escaping (T) -> (),
                                         onErrorResult: ((String) -> ())?) {
        DispatchQueue.main.async {
            switch result {
            case .success(let obj): onSuccessResult(obj)
            case .failure(let error):
                print(error.localizedDescription)
                onErrorResult?(error.localizedDescription)
            }
        }
    }
    
//    func getTop(with topType: TopFilmsType,
//                page: Int,
//                onCompleted: @escaping ([Film]) -> (),
//                onError: ((String?) -> ())?) {
//        guard let url = API.top.getTopURL(with: topType, page: page) else { return }
//        
//        AF.request(url, headers: headers)
//            .responseDecodable(of: TopFilmsType.self) { [weak self] response in
//                self?.getResult(with: response.result,
//                                onSuccessResult: { topFilms in
//                    onCompleted(topFilms.films)
//                }, onErrorResult: onError)
//            }
//    }
    
    func getPremier(with year: Int,
                    month: Months,
                    onCompleted: @escaping ([PremierFilm]) -> (),
                    onError: ((String?) -> ())?) {
        guard let url = API.premier.getPremierURL(with: year, month: month) else { return }
        
        AF.request(url, headers: headers)
            .responseDecodable(of: Premiers.self) { [weak self] response in
                self?.getResult(with: response.result,
                                onSuccessResult: { premiers in
                    onCompleted(premiers.films)
                }, onErrorResult: onError)
            }
    }
    
//    func getImages(with url: URL,
//                   onComleted: @escaping () -> (),
//                   onError: ((String?) -> ())?) {
//        AF.request(url, headers: headers)
//            .responseDecodable(of: Images.self) { [weak self] response in
//                self?.getResult(with: response.result, onSuccessResult: { images in
//                    onComleted(images.items)
//                }, onErrorResult: onError)}
//    }
    
    func getFilters(onCompleted: @escaping (Filtered) -> (),
                    onError: ((String?) -> ())?) {
        guard let url = API.filters.url else { return }
        
        AF.request(url, headers: headers)
            .responseDecodable(of: Filtered.self) { [weak self] response in
                self?.getResult(with: response.result,
                                onSuccessResult: { filtered in
                    onCompleted(filtered)
            }, onErrorResult: onError)
        }
    }
}
