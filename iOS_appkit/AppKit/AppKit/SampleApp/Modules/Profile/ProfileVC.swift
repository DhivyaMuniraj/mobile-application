//
//  ProfileVC.swift
//  AppKit
//
//  Created by Chaitanya Soni on 25/08/22.
//

import Foundation
import UIKit

class ProfileVC: UIViewController {
	
    lazy var backButton: UIBarButtonItem = .init()
    lazy var optionsButton: UIBarButtonItem = .init()
    
    lazy var mainScrollView: UIScrollView = .init()
    lazy var mainStackView: UIStackView = .init()

    lazy var profileImageView: UIImageView = .init()
    lazy var editProfileButton: UIButton = .init()
    
    lazy var titleStackView: UIStackView = .init()
    lazy var nameLabel: UILabel = .init()
    lazy var cityLabel: UILabel = .init()
    
    lazy var personalInfoStackView: UIStackView = .init()
    lazy var addressContainerView: PersonalInfoUIView = .init()
    lazy var contactContainerView: PersonalInfoUIView = .init()
	
    lazy var optionsStackView: UIStackView = .init()
    
    lazy var ordersAndFavoriteStackView: UIStackView = .init()
    lazy var orderView: UserProfileOptionsView = .init()
    lazy var favoriteView: UserProfileOptionsView = .init()
    
    lazy var couponAndSupportStackView: UIStackView = .init()
    lazy var couponView: UserProfileOptionsView = .init()
    lazy var supportView: UserProfileOptionsView = .init()
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
        setupViews()
        addConstraints()
	}
	
	func setupUI() {
		
		self.view.backgroundColor = UIColor(displayP3Red: 244/255, green: 247/255, blue: 254/255, alpha: 1)
        
        //Navigation bar
        backButton.setAppearance(UIBarButtonItemAppearance.init(image: UIImage(systemName: "chevron.left"),
                                                                tintColor: .black,
                                                                imageRenderingMode: .alwaysTemplate))
        backButton.target = self
        backButton.action = #selector(didTapGoBack(sender:))
        
        optionsButton.setAppearance(UIBarButtonItemAppearance.init(image: UIImage(systemName: "ellipsis"),
                                                                   tintColor: .black,
                                                                   imageRenderingMode: .alwaysTemplate))
        
        self.navigationItem.setAppearance(UINavigationItemAppearance.init(leftBarButtonItem: backButton,
                                                                          rightBarButtonItem: optionsButton))
        self.navigationItem.title = "Profile"
        
        mainScrollView.setAppearance(ViewAppearance.init(backgroundColor: .clear))
        
        mainStackView.setAppearance(StackViewAppearance.init(alignment: .center,
                                                             spacing: 30,
                                                             distribution: .fillProportionally,
                                                             viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        //Profile Image
        profileImageView.setAppearance(UIImageViewAppearance.init(image: UIImage(named: "profile_image"),
                                                                  viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        editProfileButton.setAppearance(ButtonAppearance.init(buttonImage: UIImage(named: "edit_pencil"),
                                                              viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        //Profile Title
        titleStackView.setAppearance(StackViewAppearance.init(axis: .vertical,
                                                              alignment: .center,
                                                              spacing: 8,
                                                              distribution: .fillProportionally,
                                                              viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        nameLabel.setAppearance(LabelAppearance.init(text: "Ujjawal Varsney",
                                                     textAlignment: .center,
                                                     font: UIFont.boldSystemFont(ofSize: 18),
                                                     viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        cityLabel.setAppearance(LabelAppearance.init(text: "Gurugram, Haryana",
                                                     textAlignment: .center,
                                                     font: UIFont.systemFont(ofSize: 12),
                                                     viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        //Personal Info
        personalInfoStackView.setAppearance(StackViewAppearance.init(axis: .horizontal,
                                                                     spacing: 20,
                                                                     viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        
        addressContainerView.setAppearance(PersonalInfoViewAppearance.init(title: "Address",
                                                                           infoDetail: "Ambiance Tower, Sector 44, Gurugram Haryana \nPIN: 122003",
                                                                           count: "2"))
        
        contactContainerView.setAppearance(PersonalInfoViewAppearance.init(title: "Contact",
                                                                           infoDetail: "Mobile: +911234567890\nEmail: example@mail.com",
                                                                           count: "1"))
        
        optionsStackView.setAppearance(StackViewAppearance.init(axis: .vertical,
                                                                spacing: 20,
                                                                viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        //Order and Favorite
        ordersAndFavoriteStackView.setAppearance(StackViewAppearance.init(axis: .horizontal,
                                                                          spacing: 20,
                                                                          viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        orderView.setAppearance(UserProfileOptionViewAppearance.init(leftIcon: UIImage(named: "order_icon"),
                                                                     title: "Orders"))
        favoriteView.setAppearance(UserProfileOptionViewAppearance.init(leftIcon: UIImage(named: "favorite_icon"),
                                                                        title: "Favotites"))
        
        favoriteView.setAppearance(ViewAppearance.init(backgroundColor: .white,
                                                       cornerRadius: 10,
                                                       shadowRadius: 4,
                                                       shadowOpacity: 0.25,
                                                       shadowOffset: CGSize(width: 2, height: 2),
                                                       shadowColor: UIColor.init(red: 67/255, green: 24/255, blue: 255/255, alpha: 1).cgColor))
        
        //Coupon and Support
        couponAndSupportStackView.setAppearance(StackViewAppearance.init(axis: .horizontal,
                                                                         spacing: 20,
                                                                         viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        couponView.setAppearance(UserProfileOptionViewAppearance.init(leftIcon: UIImage(named: "coupon_icon"),
                                                                      title: "Coupons"))
        supportView.setAppearance(UserProfileOptionViewAppearance.init(leftIcon: UIImage(named: "support_icon"),
                                                                       title: "Support"))
	}
    
    func setupViews() {
     
        self.view.addSubview(mainScrollView)
            
        self.mainScrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(profileImageView)
        mainStackView.addArrangedSubview(titleStackView)
        mainStackView.addArrangedSubview(personalInfoStackView)
        mainStackView.addArrangedSubview(optionsStackView)
        
        profileImageView.addSubview(editProfileButton)
        
        titleStackView.addArrangedSubview(nameLabel)
        titleStackView.addArrangedSubview(cityLabel)
        
        personalInfoStackView.addArrangedSubview(addressContainerView)
        personalInfoStackView.addArrangedSubview(contactContainerView)
        
        optionsStackView.addArrangedSubview(ordersAndFavoriteStackView)
        optionsStackView.addArrangedSubview(couponAndSupportStackView)
        
        ordersAndFavoriteStackView.addArrangedSubview(orderView)
        ordersAndFavoriteStackView.addArrangedSubview(favoriteView)
        
        couponAndSupportStackView.addArrangedSubview(couponView)
        couponAndSupportStackView.addArrangedSubview(supportView)
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mainScrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.mainScrollView.topAnchor, constant: 14),
            mainStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            profileImageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.33),
            profileImageView.heightAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.33),
        ])
        
        NSLayoutConstraint.activate([
            editProfileButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            editProfileButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -20),
            editProfileButton.widthAnchor.constraint(equalToConstant: 28),
            editProfileButton.heightAnchor.constraint(equalToConstant: 28),
        ])
        
        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 20),
            titleStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -20),
            titleStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let width = (self.view.frame.width / 2) - 30
        NSLayoutConstraint.activate([
            addressContainerView.widthAnchor.constraint(equalToConstant: width),
            addressContainerView.heightAnchor.constraint(equalToConstant: 170)
        ])
        
        NSLayoutConstraint.activate([
            contactContainerView.widthAnchor.constraint(equalToConstant: width),
            contactContainerView.heightAnchor.constraint(equalToConstant: 170)
        ])
       
        NSLayoutConstraint.activate([
            orderView.widthAnchor.constraint(equalToConstant: width),
            orderView.heightAnchor.constraint(equalToConstant: 46)
        ])
        
        NSLayoutConstraint.activate([
            favoriteView.widthAnchor.constraint(equalToConstant: width),
            favoriteView.heightAnchor.constraint(equalToConstant: 46)
        ])
        
        NSLayoutConstraint.activate([
            couponView.widthAnchor.constraint(equalToConstant: width),
            couponView.heightAnchor.constraint(equalToConstant: 46)
        ])
        
        NSLayoutConstraint.activate([
            supportView.widthAnchor.constraint(equalToConstant: width),
            supportView.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    @objc func didTapGoBack(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
