//
//  RecommendedMainCollectionViewCell.swift
//  AppKit
//
//  Created by Jyoti Luhana on 07/09/22.
//

import UIKit

class RecommendedMainCollectionViewCell: UICollectionViewCell {
    
    lazy var recommendedCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
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
        self.recommendedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.recommendedCollectionView.register(RecommendedCollectionViewCell.self, forCellWithReuseIdentifier: "RecommendedCollectionViewCell")
    }
    
    func setupViews() {
        self.addSubview(recommendedCollectionView)
    }
    
    func addConstaints() {
        recommendedCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        recommendedCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        recommendedCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        recommendedCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
}

extension RecommendedMainCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedCollectionViewCell", for: indexPath) as? RecommendedCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Recommended index: \(indexPath.row)")
    }
}

extension RecommendedMainCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width/2 - 30, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 20, left: 10, bottom: 20, right: 10)
    }
}
