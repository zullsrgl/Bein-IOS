//
//  SearchViewTableViewCell.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 12.12.2023.
//

import UIKit
import Kingfisher
import AVKit

class SearchViewTableViewCell: UITableViewCell {
    static let identifier = "SearchViewTableViewCell"
    let vc = FavoriteMoviesViewController()
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
    //MARK: INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(movieImage)
        contentView.addSubview(watchButon)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(voteCountLabel)
        movieNameLabel.numberOfLines = 0
        watchButon.addTarget(self, action: #selector(toDetails), for: .touchUpInside)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func avPlayerForSearch(url: URL){
        
        
    }
    //MARK: Alert Message
    @objc func toDetails(_sender : Int){
        let alertController = UIAlertController(title: "Ne izlemek istersin?", message: "Ne izlemek istediğinizi seçiniz", preferredStyle: .actionSheet)
        let izleAction = UIAlertAction(title: "İzlemeye Başla", style: .default) { [weak self] (action) in
               guard let self = self else { return }
               // Burada izleme işlemini başlat
               if let url = URL(string: "https://embed-ssl.wistia.com/deliveries/cc8402e8c16cc8f36d3f63bd29eb82f99f4b5f88/accudvh5jy.mp4") {
                   let playerController = AVPlayerViewController()
                   let player = AVPlayer(url: url)
                   playerController.player = player
                   playerController.allowsPictureInPicturePlayback = true
                   playerController.player?.play()
                   if let viewController = self.findViewController() {
                       viewController.present(playerController, animated: true, completion: nil)
                   }
               }
           }
        alertController.addAction(izleAction)
        let fragmanAction = UIAlertAction(title: "Fragmanı İzle", style: .default) { [weak self] (action) in
                guard let self = self else { return }
                if let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/v5/prog_index.m3u8") {
                    let playerController = AVPlayerViewController()
                    let player = AVPlayer(url: url)
                    playerController.player = player
                    playerController.allowsPictureInPicturePlayback = true
                    playerController.player?.play()
                    if let viewController = self.findViewController() {
                        viewController.present(playerController, animated: true, completion: nil)
                    }
                }
            }
            alertController.addAction(fragmanAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
          
          if let viewController = self.findViewController() {
              viewController.present(alertController, animated: true, completion: nil)
          }
    print("Search View Table View Cell watch buton ")
    }
    
    //MARK: Configure
    
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
    //MARK: Constraints
    func setConstraint(){
        
        movieImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(150)
            make.width.equalTo(100)
            
        }
        watchButon.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.bottom.equalToSuperview()
       }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.top).offset(32)
            make.left.equalTo(movieImage.snp.right).offset(20)
            make.right.equalToSuperview()
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


extension UIView {
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            responder = nextResponder
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension SearchViewTableViewCell : WatchButonCellDelegate {
    func presentPlayerController(_ playerController: AVPlayerViewController) {
        if let viewController = self.findViewController() {
            viewController.present(playerController, animated: true, completion: nil)
        }
    }
}
