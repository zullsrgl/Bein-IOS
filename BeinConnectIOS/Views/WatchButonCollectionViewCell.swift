//
//  WatchButonCollectionViewCell.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 3.12.2023.
//

import UIKit

class WatchButonCollectionViewCell: UITableViewCell {
    static let identifire = "buton"
    
    var watchButon : UIButton = {
        var buton = UIButton()
        buton.setTitle("İzle", for: .normal)
        buton.backgroundColor = .black
        buton.layer.cornerRadius = 10
        buton.addTarget(self, action: #selector(watchButonClick), for: .touchUpInside)
        buton.layer.borderWidth = 1.0
        buton.layer.borderColor = UIColor.white.cgColor
        buton.translatesAutoresizingMaskIntoConstraints = false
        
        return buton
    }()
    
    var fragmanButon : UIButton = {
        var buton = UIButton()
        buton.frame = CGRect(x: 20, y: 20, width: 100, height: 40)
        buton.setTitle("Fragman İzle", for: .normal)
        buton.backgroundColor = .black
        buton.layer.cornerRadius = 10
        buton.addTarget(self, action: #selector(fragmanButonClick), for: .touchUpInside)
        buton.layer.borderWidth = 1.0
        buton.layer.borderColor = UIColor.white.cgColor
        buton.translatesAutoresizingMaskIntoConstraints = false
        
        return buton
    }()
    @objc func watchButonClick() {
        
        print("watch buton click")
    }
    
    @objc func fragmanButonClick(){
        print("fragman buton click")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(watchButon)
        contentView.addSubview(fragmanButon)
        setConstrainttoWatchButon()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstrainttoWatchButon(){
        watchButon.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.right.equalToSuperview()
              }
              
        fragmanButon.snp.makeConstraints { make in
            make.top.equalTo(watchButon.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
    }
    
    
}
