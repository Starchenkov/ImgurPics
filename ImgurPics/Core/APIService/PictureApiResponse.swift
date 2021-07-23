//
//  PicsApiResponse.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

struct PictureApiResponse: Decodable {
    let data: [GalleryData]?
}

struct GalleryData: Decodable {
    let id: String?
    let title: String?
    let images: [Image]?
}

struct Image: Decodable {
    let id: String?
    let link: String?
    let type: String?
}
