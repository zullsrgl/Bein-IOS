//
//  DetailsCollectionViewCell.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 24.11.2023.
//

import UIKit
import SDWebImage

class DetailsCollectionViewCell: UITableViewCell {
    static let identifierButton = "WatchButtonCell"
    static let identifire = "DetailsCollectionViewCell"
    
    var movieImageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemBackground
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        return image
    }()
    var movieNameLabel: UILabel = {
        var label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

 
    var voteCountLabel : UILabel  = {
        var label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    var releaseDateLabel : UILabel = {
        var label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
 
    var movieDetail: MovieDetail? {
        didSet {
            movieNameLabel.text = movieDetail?.original_title
            releaseDateLabel.text = movieDetail?.release_date
            if let vote  = movieDetail?.vote_average {
                voteCountLabel.text = "\(String(describing: vote))"
            }
            let basePosterURL = "https://image.tmdb.org/t/p/w500/"

            if let posterPath = movieDetail?.poster_path,
               let posterURL = URL(string: basePosterURL + posterPath) {
                movieImageView.sd_setImage(with: posterURL, placeholderImage: UIImage(named: "placeholder.png"))
            } else {
                movieImageView.image = UIImage(named: "placeholder.png")
            }
        }
    }
        
    
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
            make.bottom.equalTo(voteCountLabel.snp.top).offset(-12)
            make.left.equalTo(movieImageView.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        movieImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalTo(20)
            make.height.equalTo(200)
            make.width.equalTo(132)
        }
        voteCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalTo(movieImageView.snp.right).offset(20)
            }
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(voteCountLabel.snp.top).offset(30)
            make.left.equalTo(movieImageView.snp.right).offset(20)
           
        }
    }
}
