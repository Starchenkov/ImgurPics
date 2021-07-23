//
//  DetailScreenViewController.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

import UIKit

protocol IDetailScreenView: AnyObject {
    func updateComments()
    func updatePictureInfo(info: InfoPictureViewModel)
    func showAlert(message: String)
}

final class DetailScreenViewController: UIViewController, UITableViewDataSource {
    private let presenter: IDetailScreenPresenter
    private let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.allowsSelection = false
        return tableview
    }()
    
    private var typeLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = .black
        lable.numberOfLines = 1
        return lable
    }()
    
    private var widthLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = .black
        lable.numberOfLines = 1
        return lable
    }()
    
    private var heightLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = .black
        lable.numberOfLines = 1
        return lable
    }()
    
    private var viewsLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = .black
        lable.numberOfLines = 1
        return lable
    }()
    
    init(presenter: IDetailScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail Info"
        self.view.backgroundColor = .white
        self.configureTableView()
        self.configureNavigationBar()
        self.addSubviews()
        self.makeConstraints()
        self.presenter.viewDidLoad(view: self)
    }
}

extension DetailScreenViewController: IDetailScreenView {
    func updateComments() {
        self.tableview.reloadData()
    }
    
    func updatePictureInfo(info: InfoPictureViewModel) {
        self.typeLabel.text = info.type
        self.widthLabel.text = info.width
        self.heightLabel.text = info.height
        self.viewsLabel.text = info.views
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: Constants.alertTitleRequestError, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.alertActionTextOK, style: .default, handler:  nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension DetailScreenViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.getCommentsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: CommentTableViewCell.indentifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        self.presenter.configureCommentCell(cell: cell, indexPath: indexPath)
        return cell
    }
}

private extension DetailScreenViewController {
    private func configureTableView() {
        self.tableview.dataSource = self
        self.tableview.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.indentifier)
        self.tableview.separatorStyle = .none
    }
    
    private func addSubviews() {
        self.view.addSubview(self.typeLabel)
        self.view.addSubview(self.heightLabel)
        self.view.addSubview(self.widthLabel)
        self.view.addSubview(self.viewsLabel)
        self.view.addSubview(self.tableview)
    }
    
    private func makeConstraints() {
        self.typeLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.typeLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        self.typeLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        
        self.widthLabel.topAnchor.constraint(equalTo: self.typeLabel.bottomAnchor, constant: 5).isActive = true
        self.widthLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        self.widthLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        
        self.heightLabel.topAnchor.constraint(equalTo: self.widthLabel.bottomAnchor, constant: 5).isActive = true
        self.heightLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        self.heightLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        
        self.viewsLabel.topAnchor.constraint(equalTo: self.heightLabel.bottomAnchor, constant: 5).isActive = true
        self.viewsLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        self.viewsLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        
        self.tableview.topAnchor.constraint(equalTo: self.viewsLabel.bottomAnchor, constant: 10).isActive = true
        self.tableview.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.tableview.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.tableview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func configureNavigationBar() {
        let leftBarItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward.circle"), style: .done, target: self, action: #selector(self.closeTapped))
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc private func closeTapped() {
        self.presenter.closeTapped()
    }
}
