//
//  CommentTableViewCell.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

import UIKit

final class CommentTableViewCell: UITableViewCell {
    
    static let indentifier = "CommentTableViewCell"
    
    private var autorLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = .black
        lable.numberOfLines = 1
        return lable
    }()
    
    private var commentLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.textColor = .gray
        lable.numberOfLines = 0
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommentTableViewCell
{
    func set(vm: CommentViewModel) {
        self.autorLabel.text = vm.autor
        self.commentLabel.text = vm.comment
    }
    
    private func addSubviews() {
        self.contentView.addSubview(self.autorLabel)
        self.contentView.addSubview(self.commentLabel)
    }
    
    private func makeConstraints() {
        self.autorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.autorLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5).isActive = true
        self.autorLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5).isActive = true
        
        self.commentLabel.topAnchor.constraint(equalTo: self.autorLabel.bottomAnchor, constant: 5).isActive = true
        self.commentLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5).isActive = true
        self.commentLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5).isActive = true
        self.commentLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
    }
}
