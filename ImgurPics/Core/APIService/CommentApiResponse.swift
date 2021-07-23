//
//  CommentApiResponse.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

struct CommentApiResponse: Decodable {
    let data: [CommentData]?
}

struct CommentData: Decodable {
    let author: String?
    let comment: String?
}
