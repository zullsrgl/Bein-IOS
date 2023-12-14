//
//  SearchViewTableViewCell.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 12.12.2023.
//

import UIKit

class SearchViewTableViewCell: UITableViewCell {
    static let identifier = "SearchViewTableViewCell"
    var movieImage : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let movieNameLabel : UILabel = {
        var label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    var watchButon : UIButton = {
        var buton = UIButton()
        var playSymbol = UIImage(systemName: "play.circle")
        buton.setImage(playSymbol, for: .normal)
        return buton
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(movieImage)
        contentView.addSubview(watchButon)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with imageURL : URL?){
        var baseUrl = "https://image.tmdb.org/t/p/w1280"
        if var imageURL = imageURL {
            let fullUrl  = URL(string:  baseUrl + imageURL.absoluteString)
            print("url: \(fullUrl)")
            movieImage.kf.setImage(with: fullUrl)
        }else {
            movieImage.image = UIImage(named: "placeholder_image")
        }
        
    }
    func setConstraint(){
        
        movieImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)

            
            make.height.equalTo(150)
            make.width.equalTo(100)
            
        }
        watchButon.snp.makeConstraints { make in
            make.left.equalTo(movieImage.snp.right).offset(20)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
    
           
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(6)
            make.left.equalTo(movieImage.snp.left)
            make.right.equalTo(movieImage.snp.right)
            
        }
    }
}
