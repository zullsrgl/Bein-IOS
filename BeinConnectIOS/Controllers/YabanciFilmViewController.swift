//
//  FilmViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 7.11.2023.
//

import UIKit
import SnapKit


enum Sections : Int {
    case TrendingMovies = 0
    case TrandingTv = 1
    case Popular = 2
    case UpcomingMovies = 3
    
}

class YabanciFilmViewController: UIViewController {
    let sectionTitles: [String] = ["Trending Movies","Tranding Tv", "Popular", "Upcoming Movies"]
    private let filmFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifire)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        filmFeedTable.register(HeaderUITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderUITableViewHeaderFooterView.identifire)
        filmFeedTable.dataSource = self
        filmFeedTable.delegate = self
        filmFeedTable.backgroundColor = .black
        view.addSubview(filmFeedTable)
        view.backgroundColor = .black
    
    }
    
    override func viewDidLayoutSubviews() {
        filmFeedTable.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(110)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
  
  //private func getDatas() {
  //    APICaller.shared.getPopuler{ [weak self] result in
  //        switch result{
  //        case .success(let titles):
  //            DispatchQueue.main.async {
  //                self?.trendingMovies = titles
  //                self?.filmFeedTable.reloadData()
  //            }
  //        case .failure(let error) :
  //            print(error.localizedDescription)
  //        }
  //    }
  //
  // }
}


extension YabanciFilmViewController : HeaderProtocol , DetailProtocol{
    func navigateDetailVc() {
        let detailsVc = DetailsViewController()
        navigationController?.pushViewController(detailsVc, animated: false)
    }
    
    
    func navigateToDetailScreen(index: Int) {
        let viewController = TumFilmlerViewController()
        viewController.didTapSeeAllButton(as: index)
        navigationController?.pushViewController(viewController, animated: false)
    }
}

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
    
           //cell.configure(with: trendingMovies)
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





