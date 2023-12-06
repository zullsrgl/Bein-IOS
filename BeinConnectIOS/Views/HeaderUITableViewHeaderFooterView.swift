//
//  HeaderUITableViewHeaderFooterView.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 14.11.2023.
//

import UIKit
import MapKit


protocol HeaderProtocol{
    func navigateToDetailScreen(index: Int)
}
class HeaderUITableViewHeaderFooterView: UITableViewHeaderFooterView {
    var delegate : HeaderProtocol?
    static let identifire = "HeaderUITableViewHeaderFooterView"
   let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .large)
        let seeAllSymbol = UIImage(systemName: "text.alignright", withConfiguration: symbolConfig)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func seeAllMovie(_ sender: UIButton) {
        var tappedIndex = sender.tag
         print("index path: \(sender.tag)")
         delegate?.navigateToDetailScreen(index: tappedIndex)
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
    func configure(title: String, buttonIndex: Int) {
        titleLabel.text = title
        seeAllButton.tag = buttonIndex
        seeAllButton.addTarget(self, action: #selector(seeAllMovie), for: .touchUpInside)
    }
}


