//
//  MainScreenRouter.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

import UIKit

protocol IMainScreenRouter {
    func showDetailInfo(for picture: PictureModel)
}

final class MainScreenRouter: IMainScreenRouter {
    var controller: UIViewController?
    
    func showDetailInfo(for picture: PictureModel) {
        let controller = DetailScreenAssembly().build(selectedPicture: picture)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .fullScreen
        self.controller?.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
