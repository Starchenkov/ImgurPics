//
//  DetailScreenAssembly.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

import UIKit

final class DetailScreenAssembly {
    func build(selectedPicture: PictureModel) -> UIViewController {
        let router = DetailScreenRouter()
        let networkManager = NetworkManager.instance
        let presenter = DetailScreenPresenter(selectedPicture: selectedPicture, router: router, networkManager: networkManager)
        let controller = DetailScreenViewController(presenter: presenter)
        router.controller = controller
        return controller
    }
}
