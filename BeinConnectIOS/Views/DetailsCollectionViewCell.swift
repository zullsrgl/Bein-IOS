//
//  DetailsCollectionViewCell.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 24.11.2023.
//

import UIKit
import SDWebImage

class DetailsCollectionViewCell: UITableViewCell {
    var savedMovies : [MovieDetail] = []
    var savedMovieIds: [Int] = []
    static let identifierButton = "WatchButtonCell"
    static let identifire = "DetailsCollectionViewCell"
    
    var movieImageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
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
    var saveButton : UIButton = {
        var button = UIButton()
        var image = UIImage(systemName: "heart")
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 12
        return button
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
        contentView.addSubview(saveButton)
        saveButton.tintColor = .red
        saveButton.addTarget(self, action: #selector(saveButonClick), for: .touchUpInside)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func saveButonClick() {
        
        if let movieDetail = movieDetail {
            savedMovies.append(movieDetail)
        }
        
        if let movieId = movieDetail?.id {
            savedMovieIds.append(movieId)
        }
        print("save movie id: \(savedMovieIds)")
        print("save button click : \(String(describing: movieDetail))")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(movieDetail)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            if json != nil {print("json: \(json!)")}
            var favouritesList = (UserDefaults.standard.array(forKey: "favourites") as? [String]) ?? []
            favouritesList.append(json!)
            UserDefaults.standard.set(favouritesList, forKey: "favourites")
        }catch {}
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
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(20)
            make.left.equalTo(movieImageView.snp.right).offset(20)
        }
    }
}
