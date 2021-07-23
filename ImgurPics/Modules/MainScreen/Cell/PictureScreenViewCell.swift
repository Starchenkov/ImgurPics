//
//  PictureScreenViewCell.swift
//  ImgurPics
//
//  Created by Sergey Starchenkov on 23.07.2021.
//

import UIKit
import SDWebImage

final class PictureScreenViewCell: UICollectionViewCell {
    static let identifier = "PictureScreenCell"
    
    private var pictureImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var pictureTitleLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 15)
        lable.textColor = .red
        lable.numberOfLines = 0
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PictureScreenViewCell
{
    func set(vm: PictureScreenViewModel) {
        self.pictureImageView.sd_setImage(with: URL(string: vm.imageLink), completed: nil)
        self.pictureTitleLabel.text = vm.title
    }
    
    private func addSubviews() {
        self.contentView.addSubview(self.pictureImageView)
        self.contentView.addSubview(self.pictureTitleLabel)
    }
    
    private func makeConstraints() {
        self.pictureImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.pictureImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.pictureImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        self.pictureImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.9).isActive = true
        
        self.pictureTitleLabel.topAnchor.constraint(equalTo: self.pictureImageView.bottomAnchor).isActive = true
        self.pictureTitleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.pictureTitleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
    }
}
