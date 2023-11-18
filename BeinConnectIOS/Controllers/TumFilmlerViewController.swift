//
//  TumFilmlerViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 14.11.2023.
//

import UIKit
import SnapKit
import MapKit

class TumFilmlerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var backButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UINavigationBar.appearance().backIndicatorImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle("Back", for: .normal)
        button.setTitleColor(button.tintColor, for: .normal)

        return button
   
   
    }()
   var collectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.size.width/3.3,
                                 height: view.frame.size.height/4.2)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifire)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .black
        view.addSubview(collectionView!)
        view.addSubview(backButton)
        
        
    
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalTo(backButton.snp.bottom)
            make.right.equalToSuperview().offset(-5)
        }
   
        backButton.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(50)

        }
    }
    
    func allMovieToYabanciFilm(){
    
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifire, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .systemGreen
        return cell
    }
}



