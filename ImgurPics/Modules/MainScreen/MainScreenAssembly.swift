//
//  MainScreenAssembly.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

import UIKit

final class MainScreenAssembly {
    func build() -> UIViewController {
        let router = MainScreenRouter()
        let networkManager = NetworkManager.instance
        let presenter = MainScreenPresenter(router: router, networkManager: networkManager)
        let controller = MainScreenViewController(presenter: presenter)
        router.controller = controller
        return controller
    }
}
