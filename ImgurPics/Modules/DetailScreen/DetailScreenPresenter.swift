//
//  DetailScreenPresenter.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

import Foundation

protocol IDetailScreenPresenter {
    func viewDidLoad(view: IDetailScreenView)
    func getCommentsCount() -> Int
    func configureCommentCell(cell: CommentTableViewCell, indexPath: IndexPath)
    func closeTapped()
}

final class DetailScreenPresenter {
    private weak var view: IDetailScreenView?
    private let router: IDetailScreenRouter
    private let networkManager: INetworkManager
    private let selectedPicture: PictureModel
    private var commentsArray = [CommentModel]()
    
    init(selectedPicture:PictureModel, router: IDetailScreenRouter, networkManager: INetworkManager) {
        self.selectedPicture = selectedPicture
        self.router = router
        self.networkManager = networkManager
    }
}

extension DetailScreenPresenter: IDetailScreenPresenter {
    func viewDidLoad(view: IDetailScreenView) {
        self.view = view
        self.displayPictureInfo()
        self.displayComments()
    }
    
    func getCommentsCount() -> Int {
        return self.commentsArray.count
    }
    
    func configureCommentCell(cell: CommentTableViewCell, indexPath: IndexPath) {
        let vm = convertCommentModelToCellViewModel(comment: commentsArray[indexPath.row])
        cell.set(vm: vm)
    }
    
    func closeTapped() {
        self.router.close()
    }
}

private extension DetailScreenPresenter {
    private func displayPictureInfo() {
        self.networkManager.fetchPictureInfo(for: self.selectedPicture.idImage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success (let infoResponse):
                if let safeInfoPictureDate = infoResponse.data {
                    let info = self.convertResponseInfoPictureDataToInfoModel(infoData: safeInfoPictureDate)
                    let vm = self.convertInfoPictureModelToCellViewModel(info: info)
                    DispatchQueue.main.async {
                        self.view?.updatePictureInfo(info: vm)
                    }
                }
                return
            case .failure( _):
                DispatchQueue.main.async {
                    self.view?.showAlert(message: Constants.alertMessageRequestError)
                }
                break
            }
        }
    }
    
    private func displayComments() {
        self.networkManager.fetchCommentsData(for: self.selectedPicture.idGallery) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success (let commentResponse):
                if let safeCommentsDate = commentResponse.data {
                    self.commentsArray = self.convertResponseCommentDataToCommentModel(commentsData: safeCommentsDate)
                    DispatchQueue.main.async {
                        self.view?.updateComments()
                    }
                }
                return
            case .failure( _):
                DispatchQueue.main.async {
                    self.view?.showAlert(message: Constants.alertMessageRequestError)
                }
                break
            }
        }
    }
    
    private func convertResponseInfoPictureDataToInfoModel(infoData: InfoData) -> InfoPictureModel {
        let info = InfoPictureModel(type: infoData.type ?? "",
                                    width: infoData.width ?? 0,
                                    height: infoData.height ?? 0,
                                    views: infoData.views ?? 0)
        return info
    }
    
    private func convertResponseCommentDataToCommentModel(commentsData: [CommentData]) -> [CommentModel] {
        var result = [CommentModel]()
        for commentItem in commentsData {
            guard let autor = commentItem.author,
                  let comment = commentItem.comment else { break }
            let post = CommentModel(autor: autor, comment: comment)
            result.append(post)
        }
        return result
    }
    
    private func convertCommentModelToCellViewModel(comment: CommentModel) -> CommentViewModel {
        let vm = CommentViewModel(autor: comment.autor, comment: comment.comment)
        return vm
    }
    
    private func convertInfoPictureModelToCellViewModel(info: InfoPictureModel) -> InfoPictureViewModel {
        let vm = InfoPictureViewModel(type: "type: \(info.type)",
                                      width: "width: \(info.width)px",
                                      height: "height: \(info.height)px",
                                      views: "views: \(info.views)")
        return vm
    }
}

