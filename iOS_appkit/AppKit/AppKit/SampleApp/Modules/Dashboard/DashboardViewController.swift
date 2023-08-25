//
//  DashboardViewController.swift
//  AppKit
//
//  Created by Chaitanya Soni on 25/08/22.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    
    var viewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var searchBar: UITextField = .init()
    
    lazy var mainCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
        setupViews()
        addConstraints()
        setupUI()
	}
	
	func setupUI() {
		
		self.view.backgroundColor = UIColor(displayP3Red: 244/255, green: 247/255, blue: 254/255, alpha: 1)
        
        //Search Bar
        self.searchBar.setAppearance(TextFieldAppearance.init(font: UIFont.systemFont(ofSize: 12),
                                                              placeholder: "Search...",
                                                              showsClearButton: .whileEditing,
                                                              returnKey: .done,
                                                              leftImage: UIImage(systemName: "magnifyingglass"),
                                                              leftImageSize: 16,
                                                              leftImagePadding: 16,
                                                              leftImageColor: .black,
                                                              viewAppearance: ViewAppearance.init(backgroundColor: .white,
                                                                                                  cornerRadius: 22)))
        
        //Main Collection View
        self.mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.mainCollectionView.register(BannerMainCollectionViewCell.self, forCellWithReuseIdentifier: "BannerMainCollectionViewCell")
        self.mainCollectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        self.mainCollectionView.register(RecommendedMainCollectionViewCell.self, forCellWithReuseIdentifier: "RecommendedMainCollectionViewCell")

	}
    
    func setupViews() {
        
        self.view.addSubview(searchBar)
        self.view.addSubview(mainCollectionView)
        
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 36),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -36),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerMainCollectionViewCell", for: indexPath) as! BannerMainCollectionViewCell
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as! HeaderCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedMainCollectionViewCell", for: indexPath) as! RecommendedMainCollectionViewCell
            return cell
        }
    }
    
}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  indexPath.row == 0  ?   CGSize(width: self.view.frame.width, height: 240) :
                indexPath.row == 1  ?   CGSize(width: self.view.frame.width, height: 40) :
                                        CGSize(width: self.view.frame.width, height: 550)
    }
    
}
