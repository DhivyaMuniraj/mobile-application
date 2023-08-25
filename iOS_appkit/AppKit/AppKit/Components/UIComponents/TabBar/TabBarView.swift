//
//  TabBarView.swift
//  AppKit
//
//  Created by Jyoti Luhana on 14/09/22.
//

import UIKit

protocol TabBarViewDelegate {
    func didTapTabButton(withIndex selectedIndex: Int)
}

class TabBarView: UIView {

    lazy var scrollView: UIScrollView = .init()
    
    lazy var mainStackView: UIStackView = .init()
    
    var tabViewData: [TabViewData] = []
    var selectedTab: Int = 0
    var delegate: TabBarViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(tabViewData: [TabViewData],selectedIndex: Int) {
        self.init(frame: CGRect.zero)
        
        self.selectedTab = selectedIndex
        self.tabViewData = tabViewData
        self.setupViews()
        self.addConstraints()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        self.setAppearance(ViewAppearance.init(backgroundColor: .white, cornerRadius: 10, shadowRadius: 4, shadowOpacity: 0.15, shadowOffset: CGSize(width: 0, height: -4), shadowColor: UIColor.init(red: 67/255, green: 24/255, blue: 255/255, alpha: 1).cgColor, translatesAutoresizingMaskIntoConstraints: false))
        
        scrollView.setAppearance(ViewAppearance.init(backgroundColor: .white,
                                                     cornerRadius: 10,
                                                     clipsToBounds: true,
                                                     translatesAutoresizingMaskIntoConstraints: false))
        
        mainStackView.setAppearance(StackViewAppearance.init(axis: .horizontal, alignment: .leading, spacing: 0, distribution: .fillEqually, viewAppearance: ViewAppearance.init(backgroundColor: .clear, translatesAutoresizingMaskIntoConstraints: false)))
        
        self.updateUI(selectedIndex: selectedTab)
        
    }
    
    @objc func didTapTabButton(_ sender: UIButton) {
        self.delegate?.didTapTabButton(withIndex: sender.tag)
        self.updateUI(selectedIndex: sender.tag)
    }
    
    func setupViews() {
        
        self.addSubview(scrollView)
        
        self.scrollView.addSubview(mainStackView)
        
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
    
    func updateUI(selectedIndex: Int) {
        self.selectedTab = selectedIndex
        
        mainStackView.arrangedSubviews.forEach { (view) in
            mainStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for (index, tab) in tabViewData.enumerated() {
            let tabButton = UIButton()
            tabButton.setAppearance(ButtonAppearance.init(textColor: .blue,
                                                          buttonTitle: index == selectedIndex ? tab.title : "",
                                                          imageEdgeInsets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 8),
                                                          buttonImage: UIImage(named: tab.icon)?.withRenderingMode(.alwaysTemplate),
                                                          buttonPosition: .forceLeftToRight,
                                                          tintColor: index == selectedIndex ? .blue : .black,
                                                          font: UIFont.systemFont(ofSize: 12),
                                                          viewAppearance: ViewAppearance.init(
                                                            backgroundColor: index == selectedIndex ? UIColor.init(red: 244/255, green: 247/255, blue: 254/255, alpha: 1) : .clear,
                                                            cornerRadius: 15,
                                                            translatesAutoresizingMaskIntoConstraints: false)))
            
            tabButton.imageView?.frame = CGRect(origin: .zero, size: CGSize(width: 8, height: 8))
            mainStackView.addArrangedSubview(tabButton)
            
            tabButton.tag = index
            tabButton.addTarget(self, action: #selector(didTapTabButton(_:)), for: .touchUpInside)
        
            tabButton.widthAnchor.constraint(equalTo: self.mainStackView.widthAnchor, multiplier: 0.25).isActive = true
            tabButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
    }
}
