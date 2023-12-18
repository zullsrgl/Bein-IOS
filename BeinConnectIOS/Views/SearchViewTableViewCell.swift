//
//  SearchViewTableViewCell.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 12.12.2023.
//

import UIKit
import Kingfisher

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
        label.textAlignment = .left
        return label
    }()
    
    var watchButon : UIButton = {
        var buton = UIButton()
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
        var playSymbol = UIImage(systemName: "play.circle" , withConfiguration: symbolConfig)
        buton.tintColor = .white
        buton.setImage(playSymbol, for: .normal)
        return buton
    }()

    var voteAverageLabel : UILabel = {
        var label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    var voteCountLabel : UILabel = {
        var label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(movieImage)
        contentView.addSubview(watchButon)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(voteCountLabel)
        watchButon.addTarget(self, action: #selector(toDetails), for: .touchUpInside)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func toDetails(_sender : Int){
        print("Search View Table View Cell watch buton")
    }
    
    func configure(with movie : Title){
        
        if let imageURL = URL(string: movie.poster_path ?? "") {
            let baseUrl = "https://image.tmdb.org/t/p/w1280"
            let fullUrl = URL(string: baseUrl + imageURL.absoluteString)
            print("url: \(String(describing: fullUrl))")
            if let url = fullUrl {
                movieImage.kf.setImage(with: url)
            }
            else {
                print("kf error")
            }
            
        }
        else {
            movieImage.image = UIImage(named: "placeholder_image")
        }
        
        movieNameLabel.text = movie.original_name ?? movie.original_title
        voteAverageLabel.text = "Vote Average: \(String(describing: movie.vote_average))"
        voteCountLabel.text = "Vote Count: \(String(describing: movie.vote_count))"
        
    }
    func setConstraint(){
        
        movieImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(150)
            make.width.equalTo(100)
            
        }
        watchButon.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
       }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.top).offset(32)
            make.left.equalTo(movieImage.snp.right).offset(20)
            make.width.equalTo(contentView.frame.width-20)
           
            
        }
        
        voteAverageLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(10)
            make.left.equalTo(movieImage.snp.right).offset(20)
        }
        voteCountLabel.snp.makeConstraints { make in
            make.top.equalTo(voteAverageLabel.snp.bottom).offset(10)
            make.left.equalTo(movieImage.snp.right).offset(20)
        }
    }
}


