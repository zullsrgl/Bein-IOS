//
//  TitleCollectionViewCell.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 8.11.2023.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "TitleCollectionViewCell"
    private var movieNameList :  [Title] = [Title]()
    
    let  posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let movieName : UILabel = {
        var label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        //label.text = "Deneme deneme"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        contentView.addSubview(movieName)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.layer.cornerRadius = 16
     
        
    }
    private func setupCell() {
        contentView.backgroundColor = .black
        layer.cornerRadius = 10
    }
    public func configure(with model:  Title?){
        
        if model == nil {
            return
        }
        
        if let posterPath = model?.poster_path {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(String(describing: posterPath))") else {
                return
            }
            
            posterImageView.sd_setImage(with: url , completed: nil)
        }
        
        posterImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        movieName.snp.makeConstraints{ make in
            make.top.equalTo(posterImageView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        
        }
        
       // print("updated: \(model?.original_name ?? model?.original_title)")
        
        movieName.text = model?.original_name ?? model?.original_title
    }
}



