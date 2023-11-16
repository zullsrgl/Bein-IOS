//
//  HeaderUITableViewHeaderFooterView.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 14.11.2023.
//

import UIKit
import MapKit


extension UIApplication {
      static var key: UIWindow? {
        if #available(iOS 13, *) {
           return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
           return UIApplication.shared.keyWindow
        }
     }
   }


class HeaderUITableViewHeaderFooterView: UITableViewHeaderFooterView {
    
  
    static let identifire = "HeaderUITableViewHeaderFooterView"
    var navigation : UINavigationController?
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .large)
        let seeAllSymbol = UIImage(systemName: "text.alignright", withConfiguration: symbolConfig)
        button.addTarget(self, action: #selector(seeAllMovie), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(seeAllSymbol, for: .normal)
        button.isUserInteractionEnabled = true
        button.layer.masksToBounds = true
        button.tintColor = .white
        return button
    }()
    


    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    @objc func seeAllMovie() {
        let rootViewController = UINavigationController(rootViewController: TumFilmlerViewController())
        UIApplication.key?.rootViewController = rootViewController
        let vc = TumFilmlerViewController()
        rootViewController.pushViewController(vc, animated: true)
    }
    
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        contentView.backgroundColor = .black
        contentView.addSubview(titleLabel)
        contentView.addSubview(seeAllButton)

        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }

        seeAllButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(0)
            make.centerY.equalToSuperview()
        }
    }

    func configure(title: String) {
        titleLabel.text = title
    }
}



