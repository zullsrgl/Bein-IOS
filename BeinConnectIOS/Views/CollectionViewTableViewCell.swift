//
//  CollectionViewTableViewCell.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 7.11.2023.
//

import UIKit
import SDWebImage

class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifire = "CollectionViewTableViewCell"
    private var titleList :  [Title] = [Title]()
    var title: String? {  didSet {categoryTitle.text = title}}
 
    
    let collectionView : UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.itemSize = CGSize(width: 140, height: 240)
          layout.scrollDirection = .horizontal
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
          collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifire)
          collectionView.backgroundColor = .black
          return collectionView
      }()
      private var categoryTitle : UILabel = {
          var label = UILabel()
          label.textColor = .white
          return label
      }()
    private var seeAllButton : UIButton = {
        var button = UIButton(type: .system)
        //let symbolConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .large)
        //let seeAllSymbol = UIImage(systemName: "text.alignright", withConfiguration: symbolConfig)
        //button.setImage(seeAllSymbol, for: .normal)
        //button.isUserInteractionEnabled = true
        button.setTitle("show all", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.masksToBounds = true
        button.tintColor = .white
        return button

    }()
    
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        setupCollectionView()

        

    }
    required init?(coder: NSCoder) {
          fatalError()
      }
    
    @objc func seeAllButtonTapped() {
        print("See all button tapped")
    }
      
      override func layoutSubviews() {
          super.layoutSubviews()
          
         collectionView.frame = contentView.bounds
          print("deneme")
      }
      
      private func setupCollectionView(){
          contentView.addSubview(collectionView)
          contentView.addSubview(categoryTitle)
          contentView.addSubview(seeAllButton)

          seeAllButton.snp.makeConstraints { make in
              make.right.equalToSuperview()
              make.top.equalToSuperview().offset(-24)
          }
          categoryTitle.snp.makeConstraints { make in
              make.left.equalToSuperview()
              make.top.equalToSuperview().offset(-24)
}
          collectionView.snp.makeConstraints { make in
              make.left.equalToSuperview()
              make.right.equalToSuperview()
              make.top.equalToSuperview()
              make.bottom.equalToSuperview()
          }
        
          
      }
      
      public func configure(with title : [Title]) {
          self.titleList = title
          DispatchQueue.main.async { [weak self] in
              self?.collectionView.reloadData()
              
          }
      }
      
  }

extension CollectionViewTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifire, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let model: Title? = titleList[indexPath.row] else {
            return  UICollectionViewCell()
        }
        cell.configure(with: model)
        
        return cell
    }
}

