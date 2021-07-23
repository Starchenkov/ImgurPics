//
//  InfoPictureApiResponse.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

struct InfoPictureApiResponse: Decodable {
    let data: InfoData?
}

struct InfoData: Decodable {
    let type: String?
    let height: Int?
    let width: Int?
    let views: Int?
}
