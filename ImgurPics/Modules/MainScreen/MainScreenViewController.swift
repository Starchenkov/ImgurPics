//
//  MainScreen.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

import UIKit

protocol IMainScreenView: AnyObject {
    func updatePictureCollection()
    func showAlert(message: String)
}

final class MainScreenViewController: UIViewController {
    private let presenter: IMainScreenPresenter
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collection.isPagingEnabled = true
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    init(presenter: IMainScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Top pictures"
        self.view.backgroundColor = .white
        self.addSubviews()
        self.configureCollectionView()
        self.addConstraints()
        self.presenter.viewDidLoad(view: self)
    }
}

extension MainScreenViewController: IMainScreenView {
    func updatePictureCollection() {
        self.collectionView.reloadData()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: Constants.alertTitleRequestError, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.alertActionTextOK, style: .default, handler:  nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.getPictureCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureScreenViewCell.identifier, for: indexPath) as? PictureScreenViewCell else { return UICollectionViewCell() }
        self.presenter.configurePictureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.pictureTapped(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeW = self.view.frame.width
        let sizeH = self.view.frame.height * 0.7
        return CGSize(width: sizeW, height: sizeH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

private extension MainScreenViewController {
    private func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(PictureScreenViewCell.self, forCellWithReuseIdentifier: PictureScreenViewCell.identifier)
    }
    
    private func addSubviews() {
        self.view.addSubview(self.collectionView)
    }
    
    private func addConstraints() {
        self.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
