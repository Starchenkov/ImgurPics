//
//  MainScreenPresenter.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

import Foundation

protocol IMainScreenPresenter {
    func viewDidLoad(view: IMainScreenView)
    func getPictureCount() -> Int
    func configurePictureCell(cell: PictureScreenViewCell, indexPath: IndexPath)
    func pictureTapped(indexPath: IndexPath)
}

final class MainScreenPresenter {
    private weak var view: IMainScreenView?
    private let router: IMainScreenRouter
    private let networkManager: INetworkManager
    private var pictureArray = [PictureModel]()
    
    init(router: IMainScreenRouter, networkManager: INetworkManager) {
        self.router = router
        self.networkManager = networkManager
    }
}

extension MainScreenPresenter: IMainScreenPresenter {
    func viewDidLoad(view: IMainScreenView) {
        self.view = view
        self.displayPicture()
    }
    
    func getPictureCount() -> Int {
        return self.pictureArray.count
    }
    
    func configurePictureCell(cell: PictureScreenViewCell, indexPath: IndexPath) {
        let picture = self.pictureArray[indexPath.row]
        let viewModelCell = self.convertPictureModelToCellViewModel(picture: picture)
        cell.set(vm: viewModelCell)
    }
    
    func pictureTapped(indexPath: IndexPath) {
        self.router.showDetailInfo(for: self.pictureArray[indexPath.row])
    }
}

private extension MainScreenPresenter {
    private func displayPicture() {
        self.networkManager.fetchPicturesData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success (let pictureResponse):
                if let safeMediaDate = pictureResponse.data {
                    self.pictureArray = self.convertResponseGalleryDataToPictureModel(mediaData: safeMediaDate)
                    DispatchQueue.main.async {
                        self.view?.updatePictureCollection()
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
    
    private func convertResponseGalleryDataToPictureModel(mediaData: [GalleryData]) -> [PictureModel] {
        var result = [PictureModel]()
        for mediaItem in mediaData {
            if mediaItem.images?.first?.type == "image/jpeg" {
                guard let idGallery = mediaItem.id,
                      let idImage = mediaItem.images?.first?.id,
                      let title = mediaItem.title,
                      let imageLink = mediaItem.images?.first?.link else { break }
                let picture = PictureModel(idGallery: idGallery,
                                           idImage: idImage,
                                           title: title,
                                           imageLink: imageLink)
                result.append(picture)
            }
        }
        return result  
    }
    
    private func convertPictureModelToCellViewModel(picture: PictureModel) -> PictureScreenViewModel {
        let vm = PictureScreenViewModel(title: picture.title, imageLink: picture.imageLink)
        return vm
    }
}
