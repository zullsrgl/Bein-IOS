//
//  FilmViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 7.11.2023.
//

import UIKit
import SnapKit

class YabanciFilm: UIViewController {
    
    let sectionTitles: [String] = ["Öne Çıkanlar", "Bu Hafta Çok İzlenenler" , "Tüm Zamanşarın En İyi Filimleri" , "Usta Yönetmenler" , "Eleştirmenlerin Gözünden", "IMDb Top Filimleri" , "Seri Filmler", "Ailece İzlenecek Filmler" , "Komedi Türk Filmleri" ,"Hayattan Hikayeler", "Müzik ve Sinama" , "Kitaptan Filmler" , "Spor Filimleri"]
    
    private let filmFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
 


    override func viewDidLoad() {
        super.viewDidLoad()
        filmFeedTable.dataSource = self
        filmFeedTable.delegate = self
        filmFeedTable.frame = view.bounds
        filmFeedTable.backgroundColor = .black
        view.addSubview(filmFeedTable)
        view.backgroundColor = .systemBackground
        
    }
}


extension YabanciFilm: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else{return}
        header.textLabel?.font = .monospacedSystemFont(ofSize: 12.0, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        tableView.sectionHeaderTopPadding = 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CollectionViewTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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



