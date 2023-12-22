//
//  WatchButonCollectionViewCell.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 3.12.2023.
//

import UIKit
import AVKit
import AVFoundation

protocol WatchButonCellDelegate: AnyObject {
    func presentPlayerController(_ playerController :AVPlayerViewController)
}

class WatchButonCollectionViewCell: UITableViewCell , AVPlayerViewControllerDelegate {
    static let identifire = "buton"
    var playerController = AVPlayerViewController()
    weak var delegate : WatchButonCellDelegate?
    
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
    
    func watchAVPlayer(url: URL){
        let player = AVPlayer(url: url)
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.allowsPictureInPicturePlayback = true
        playerController.delegate = self
        playerController.player?.play()
        delegate?.presentPlayerController(playerController)
        
    }
    @objc func watchButonClick() {
        guard let url = URL(string: "https://embed-ssl.wistia.com/deliveries/cc8402e8c16cc8f36d3f63bd29eb82f99f4b5f88/accudvh5jy.mp4") else { return}
        watchAVPlayer(url: url)
        print("watch buton click")
    }
    @objc func fragmanButonClick(){
        guard let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/v5/prog_index.m3u8") else {return}
        watchAVPlayer(url: url)
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
