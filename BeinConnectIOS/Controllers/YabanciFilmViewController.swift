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
class YabanciFilmViewController: UIViewController  {
    let sectionTitles: [String] = ["Trending Movies","Tranding Tv", "Popular", "Upcoming Movies"]
    private let filmFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifire)
        return table
    }()
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private let numberOfPages = 14
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmFeedTable.register(HeaderUITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderUITableViewHeaderFooterView.identifire)
        filmFeedTable.dataSource = self
        filmFeedTable.delegate = self
        filmFeedTable.backgroundColor = .black
        view.addSubview(scrollView)
        view.addSubview(filmFeedTable)
        view.backgroundColor = .black
        apiCaller()
    }
    override func viewDidLayoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 500)

        filmFeedTable.snp.makeConstraints{ make in
            //make.top.equalToSuperview().offset(100)
            make.top.equalTo(scrollView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    func apiCaller() {
        APICaller.shared.getUpcomingMovies{ [weak self] result in
            switch result {
            case .success(let titles):
                // Verileri aldık, şimdi görselleri ekrana yerleştirelim
                DispatchQueue.main.async {
                    self?.setupScrollView(with: titles)
                }
            case .failure(let error):
                // Hata durumunda buraya düşeriz, hata işleme kodlarını ekleyebilirsiniz
                print("Hata: \(error)")
            }
        }
    }
    func setupScrollView(with titles: [Title]) {
        for (index, title) in titles.enumerated() {
            if let posterPath = title.poster_path,
               let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
                let imageView = UIImageView()
                imageView.kf.setImage(with: posterURL)
                imageView.frame = CGRect(x: CGFloat(index) * view.frame.size.width, y: 0, width: view.frame.size.width, height: 500)
                scrollView.addSubview(imageView)
            }
        }
        scrollView.contentSize = CGSize(width: CGFloat(titles.count) * view.frame.size.width, height: 500)
    }
}


//MARK: Extansion Navigate
extension YabanciFilmViewController : HeaderProtocol , DetailProtocol{
    func navigateDetailVc(withID movieID : Int) {
        let detailsVc = DetailsViewController(movieID: movieID)
        navigationController?.pushViewController(detailsVc, animated: false)
    }
    
    
    func navigateToDetailScreen(index: Int) {
        let viewController = TumFilmlerViewController()
        viewController.didTapSeeAllButton(as: index)
        navigationController?.pushViewController(viewController, animated: false)
    }
}
//MARK: Extansion Delegate

extension YabanciFilmViewController: UITableViewDelegate, UITableViewDataSource{
    
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
        navigationController?.navigationBar.transform = .init(translationX: 0.0, y: min(0 , -offset))
    }
}





