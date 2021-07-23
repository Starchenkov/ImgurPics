//
//  NetworkManager.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

import Foundation
import Alamofire

protocol INetworkManager
{
    func fetchPicturesData(completion: @escaping (Result<PictureApiResponse, Error>) -> Void)
    func fetchCommentsData(for id: String, completion: @escaping (Result<CommentApiResponse, Error>) -> Void)
    func fetchPictureInfo(for id: String, completion: @escaping (Result<InfoPictureApiResponse, Error>) -> Void)
}

final class NetworkManager: INetworkManager
{
    private init() {}
    static let instance = NetworkManager()
    
    private let key = "Client-ID 0e5fc490db8c844"
    
    func fetchPicturesData(completion: @escaping (Result<PictureApiResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.imgur.com/3/gallery/top/top/week/1") else { return }
        let headers: HTTPHeaders = ["Authorization": key]
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: PictureApiResponse.self) { response in
                switch (response.result) {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
    
    func fetchCommentsData(for id: String, completion: @escaping (Result<CommentApiResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.imgur.com/3/gallery/\(id)/comments/best") else { return }
        let headers: HTTPHeaders = ["Authorization": key]
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: CommentApiResponse.self) { response in
                switch (response.result) {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
    
    func fetchPictureInfo(for id: String, completion: @escaping (Result<InfoPictureApiResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.imgur.com/3/image/\(id)") else { return }
        let headers: HTTPHeaders = ["Authorization": key]
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: InfoPictureApiResponse.self) { response in
                switch (response.result) {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
}
