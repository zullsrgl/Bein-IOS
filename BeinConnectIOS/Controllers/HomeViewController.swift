//
//  FilmViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 7.11.2023.
//

import UIKit
import SnapKit
import Kingfisher

enum Sections : Int {
    case TrendingMovies = 0
    case TrandingTv = 1
    case Popular = 2
    case UpcomingMovies = 3
}
class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    let sectionTitles: [String] = ["Trending Movies","Tranding Tv", "Popular", "Upcoming Movies"]
    let categoryName : [String] = ["Film" , "Dizi" ,"Çocuk", "Spor","Canlı TV"]
    
    var selectedCategory: String?
    let titleLabel = UILabel()
    
    let gradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 600, height: 50), collectionViewLayout: layout)
        collection.register(LabelCollectionViewCell.self, forCellWithReuseIdentifier: LabelCollectionViewCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    private let filmFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifire)
        return table
    }()
    //MARK: scroll view
    private let numberOfPages = 14
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
   
    
    //MARK:  viewdidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        filmFeedTable.register(HeaderUITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderUITableViewHeaderFooterView.identifire)
        filmFeedTable.dataSource = self
        filmFeedTable.delegate = self
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        filmFeedTable.backgroundColor = .black
        filmFeedTable.tableHeaderView = scrollView
        view.addSubview(filmFeedTable)
        view.addSubview(gradientView)
        view.addSubview(categoryCollectionView)
        getGradientBackGraund()
        navController()
        apiCaller()
        getDataFromHomeVC()
    }
    override func viewDidLayoutSubviews() {
        tabBarController?.tabBar.isHidden = false
        scrollView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 110, width: view.frame.size.width, height: 500)
        
        filmFeedTable.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        gradientView.snp.makeConstraints { make in
            make.top.equalTo(navigationController?.navigationBar.snp.bottom ?? 70)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationController?.navigationBar.snp.bottom ?? 70)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
    }
    //MARK: GET DATA FROM
    func getDataFromHomeVC(){
        if let category = selectedCategory {
            categoryCollectionView.isHidden = true
            titleLabel.text = category
        }
    }
    func getGradientBackGraund(){
        let colorTop = UIColor(red: 20.0 / 255.0, green: 20.0 / 255.0, blue: 20.0 / 255.0, alpha: 0.90).cgColor
        let colorBottom = UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 0.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = categoryCollectionView.bounds
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0 , 1.0]
        self.gradientView.layer.insertSublayer(gradientLayer, at: 0)
        //self.categoryCollectionView.layer.insertSublayer(gradientLayer, at: 1)
    }
    
    //MARK: Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryName.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.identifier, for: indexPath) as? LabelCollectionViewCell else { return  UICollectionViewCell() }
        cell.categoryLabel.text = categoryName[indexPath.row]
        cell.categoryLabel.tag = indexPath.row
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell =  collectionView.cellForItem(at: indexPath) as? LabelCollectionViewCell
        
        let viewController = HomeViewController()
        if indexPath.row < categoryName.count {
            viewController.selectedCategory = categoryName[indexPath.row]
        }
        navigationController?.pushViewController(viewController, animated: true)
        print(categoryName[indexPath.row])
    }
    
   //MARK: nav Controller Func
    func navController() {
        
        titleLabel.text = "beIN CONNECT"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = titleLabel
    }
    func apiCaller() {
        APICaller.shared.getUpcomingMovies{ [weak self] result in
            switch result {
            case .success(let titles):
                DispatchQueue.main.async {
                    self?.setupScrollView(with: titles)
                }
            case .failure(let error):
                print("Hata: \(error)")
            }
        }
    }
    func setupScrollView(with titles: [Title]) {
        for (index, title) in titles.enumerated() {
            if let posterPath = title.poster_path,
               let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
                let imageView = UIImageView()
                imageView.backgroundColor = .black
                imageView.tag = title.id
                imageView.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toDetails))
                imageView.addGestureRecognizer(tapGesture)
                imageView.kf.setImage(with: posterURL)
                imageView.frame = CGRect(x: CGFloat(index) * view.frame.size.width, y: 0, width: view.frame.size.width, height: 500)
                scrollView.addSubview(imageView)
            }
        }
        scrollView.contentSize = CGSize(width: CGFloat(titles.count) * view.frame.size.width, height: 500)
    }
    @objc func toDetails(_ sender: UITapGestureRecognizer){
        if let tappedImageView = sender.view as? UIImageView{
            let tappedImageID = tappedImageView.tag
            navigateDetailVc(withID: tappedImageID)
            print("Image View'a tıklandı: \(tappedImageID)")
        }
    }
}

//MARK: Extansion Navigate
extension HomeViewController : HeaderProtocol , DetailProtocol {
    func navigateDetailVc(withID movieID : Int) {
        let detailsVc = DetailsViewController(movieID: movieID)
        navigationController?.pushViewController(detailsVc, animated: true)
    }
    
    
    func navigateToDetailScreen(index: Int) {
        let viewController = TumFilmlerViewController()
        viewController.didTapSeeAllButton(as: index)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: Extansion Delegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderUITableViewHeaderFooterView.identifire) as? HeaderUITableViewHeaderFooterView else { return nil }
        headerView.configure(title: sectionTitles[section], buttonIndex: section)
        headerView.delegate = self
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifire, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        //Delegate, belirli bir olay olduğunda bir nesnenin başka bir nesneye haber göndermesine olanak tanıyan bir Design Pattern’dır’
        switch indexPath.section{
        case Sections.TrendingMovies.rawValue:
            
           APICaller.shared.getPopuler{ result in
               switch result{
               case .success(let titles):
                   cell.configure(with: titles)
               case .failure(let error) :
                   print(error.localizedDescription)
               }
           }
            cell.title = "Trending Movies"
        case Sections.TrandingTv.rawValue:
            APICaller.shared.getTrendingTvs{ result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
            cell.title = "Trending TV"
        case Sections.UpcomingMovies.rawValue :
            APICaller.shared.getUpcomingMovies{ result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
            cell.title = "Upcoming Movies"

        case Sections.Popular.rawValue:
            APICaller.shared.getPopuler{ result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
            cell.title = "Popular"
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
    }
}
