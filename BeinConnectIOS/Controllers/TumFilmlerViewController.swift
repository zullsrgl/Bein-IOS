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

    private var trendingMovies : [Title] = []
    var  selectedDataType : Int?
    var backButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UINavigationBar.appearance().backIndicatorImage, for: .normal)
        button.addTarget(self, action: #selector(allMovieToYabanciFilm), for: .touchUpInside)
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
        collectionView?.reloadData()
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

    
    private func getPopulerData(){
        APICaller.shared.getPopuler{ [weak self] result in
               switch result{
               case .success(let titles):
                   DispatchQueue.main.async {
                       self?.trendingMovies = titles
                       self?.collectionView?.reloadData()
                   }
               case .failure(let error) :
                   print(error.localizedDescription)
            }
        }
    }
    
    private func getTrendingsMoviesData(){
        APICaller.shared.getTrendingMovies { [weak self] result in
             switch result{
             case .success(let titles):
                 DispatchQueue.main.async {
                     self?.trendingMovies = titles
                     self?.collectionView?.reloadData()
                 }
             case .failure(let error) :
                 print(error.localizedDescription)
             }
         }
    }
    
    private func getTrendingTvsData(){
        APICaller.shared.getTrendingTvs { [weak self] result in
             switch result{
             case .success(let titles):
                 DispatchQueue.main.async {
                     self?.trendingMovies = titles
                     self?.collectionView?.reloadData()
                 }
             case .failure(let error) :
                 print(error.localizedDescription)
             }
         }
        
    }
    private func getUpcomingMoviesData() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result{
            case .success(let titles):
                DispatchQueue.main.async {
                    self?.trendingMovies = titles
                    self?.collectionView?.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    
    func didTapSeeAllButton(as index :Int){
        print("tapped index \(index)")
        selectedDataType = index
        if index == 0 {
            getPopulerData()
        }
        else if index == 1 {
            getTrendingTvsData()
        }
        else if index == 2 {
            getTrendingsMoviesData()
        }
        else if index == 3 {
            getUpcomingMoviesData()
        }
        else {
            print("error")
        }
        collectionView?.reloadData()
        
    }
    
    @objc func allMovieToYabanciFilm(){
        print("back button click")
        navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifire, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: trendingMovies[indexPath.row])
        return cell
    }
}
