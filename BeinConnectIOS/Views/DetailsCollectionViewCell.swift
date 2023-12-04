//
//  DetailsCollectionViewCell.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 24.11.2023.
//

import UIKit

class DetailsCollectionViewCell: UITableViewCell {
    static let identifierButton = "WatchButtonCell"
    static let identifire = "DetailsCollectionViewCell"
    var movieNameLabel: UILabel = {
        var label = UILabel()
        label.text = "Film Adı"
        label.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    
    var movieImageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .purple
        image.layer.cornerRadius = 10
        return image
    }()
    var voteCountLabel : UILabel  = {
        var label = UILabel()
        label.text = "puan : 7.2"
        label.textColor = .white
        return label
    }()
    
    var releaseDateLabel : UILabel = {
        var label = UILabel()
        label.text = "Release Date : 2023-11-30"
        label.textColor = .white
        return label
    }()
    
 
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(movieImageView)
        contentView.addSubview(voteCountLabel)
        contentView.addSubview(releaseDateLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setConstraints() {
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(20)
        }
        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.height.equalTo(200)
            make.width.equalTo(132)
        }
        voteCountLabel.snp.makeConstraints { make in
            make.left.equalTo(movieImageView.snp.right).offset(20)
            make.top.equalTo(movieImageView.snp.top).offset(30)
            
        }
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(voteCountLabel.snp.top).offset(30)
            make.left.equalTo(movieImageView.snp.right).offset(20)
        }
    }
}
