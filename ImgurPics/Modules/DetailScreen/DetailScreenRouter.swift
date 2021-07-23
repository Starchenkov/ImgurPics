//
//  DetailScreenRouter.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

import UIKit

protocol IDetailScreenRouter {
    func close()
}

final class DetailScreenRouter: IDetailScreenRouter {
    var controller: UIViewController?
    
    func close() {
        controller?.navigationController?.dismiss(animated: true, completion: nil)
    }
}
