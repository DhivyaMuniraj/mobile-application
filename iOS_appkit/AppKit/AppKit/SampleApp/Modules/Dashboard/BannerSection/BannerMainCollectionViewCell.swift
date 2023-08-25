//
//  BannerMainCollectionViewCell.swift
//  AppKit
//
//  Created by Jyoti Luhana on 07/09/22.
//

import UIKit

class BannerMainCollectionViewCell: UICollectionViewCell {
    
    lazy var bannerCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.addConstaints()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.bannerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.bannerCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
    }
    
    func setupViews() {
        self.addSubview(bannerCollectionView)
    }
    
    func addConstaints() {
        bannerCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bannerCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bannerCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bannerCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
}

extension BannerMainCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Index: \(indexPath.row)")
    }
}

extension BannerMainCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width * 0.8, height: 240)
    }
}
