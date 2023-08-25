//
//  TabBarViewController.swift
//  AppKit
//
//  Created by Jyoti Luhana on 13/09/22.
//

import Foundation
import UIKit

struct TabViewData {
    var icon: String
    var title: String
    var viewController: UIViewController
}


class TabBarViewController: UIViewController {
    
    lazy var overlayView: UIView = .init()
    
    lazy var mainContainerView: UIView = .init()
    
    lazy var menuButton: UIBarButtonItem = .init()
    
    lazy var titleImage: UIImageView = .init()
    
    lazy var profileButton: UIButton = UIButton(type: .custom)
    lazy var profileBarButton: UIBarButtonItem = .init()
    
    var tabBarView: TabBarView!
    
    var thePageVC: PageViewController!
    
    let tabViewData: [TabViewData]
    
    init(tabViewData: [TabViewData]) {
        self.tabViewData = tabViewData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var selectedPage: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setupUI()
        self.setupViews()
        self.addConstraints()
        
        self.setupSWReveal()
    }

    func setupUI() {
        
        mainContainerView.setAppearance(ViewAppearance.init(backgroundColor: .gray,
                                                          translatesAutoresizingMaskIntoConstraints: false))
        
        let childViewControllers = tabViewData.map({ $0.viewController })
        thePageVC = PageViewController(viewControllers: childViewControllers, selectedPage: selectedPage)
        addChild(thePageVC)
        thePageVC.view.translatesAutoresizingMaskIntoConstraints = false
        thePageVC.didMove(toParent: self)
        
        mainContainerView.addSubview(thePageVC.view)
        
        overlayView.setAppearance(ViewAppearance.init(backgroundColor: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6),
                                                 translatesAutoresizingMaskIntoConstraints: false))
        overlayView.alpha = 0
        
        menuButton.setAppearance(UIBarButtonItemAppearance.init(image: UIImage(systemName: "line.3.horizontal"),
                                                                tintColor: .black,
                                                                imageRenderingMode: .alwaysTemplate))
        menuButton.action = #selector(hamburgerClicked(_:))
        menuButton.target = self
        
        profileButton.setAppearance(ButtonAppearance.init(buttonImage: UIImage(named: "profile_image"),
                                                                viewAppearance: ViewAppearance.init(backgroundColor: .clear,
                                                                translatesAutoresizingMaskIntoConstraints: false)))
        profileButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileButton.addTarget(self, action: #selector(didTapProfileButton(sender:)), for: .touchUpInside)
        
        profileBarButton.customView = profileButton
        
        titleImage.setAppearance(UIImageViewAppearance.init(image: UIImage(named: "app_logo"),
                                                            viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        self.navigationItem.setAppearance(UINavigationItemAppearance.init(leftBarButtonItem: menuButton,
                                                                          rightBarButtonItem: profileBarButton,
                                                                          titleView: titleImage))
        
        tabBarView = TabBarView.init(tabViewData: tabViewData, selectedIndex: selectedPage)
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.delegate = self
    }
    
    func setupViews() {
        view.addSubview(mainContainerView)
        view.addSubview(tabBarView)
        
        view.addSubview(overlayView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        
        NSLayoutConstraint.activate([
            thePageVC.view.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            thePageVC.view.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            thePageVC.view.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            thePageVC.view.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            tabBarView.topAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func didTapProfileButton(sender: UIButton) {
        let profileVC = ProfileVC()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
}

extension TabBarViewController: TabBarViewDelegate {
    
    func didTapTabButton(withIndex selectedIndex: Int) {
        self.thePageVC.go(toIndex: selectedIndex)
    }
}

extension TabBarViewController {
    
    // setup swreveal controller
    func setupSWReveal(){
        //adding panGesture to reveal menu controller
        view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        
        //adding tap gesture to hide menu controller
        view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        
        //setting reveal width of menu controller manually
        self.revealViewController()?.rearViewRevealWidth = UIScreen.main.bounds.width * (2/3)
        
        self.revealViewController()?.delegate = self
        
    }
    
    //MARK: - action
    @objc func hamburgerClicked(_ sender: UIBarButtonItem){
        //toggle frontVC on clicking hamburger menu
        self.revealViewController()?.revealToggle(animated: true)
    }
}

extension TabBarViewController: SWRevealViewControllerDelegate {
    
    //varying alpha of overlayView with progress of panGesture to reveal or hide menu view
    func revealController(_ revealController: SWRevealViewController!, panGestureMovedToLocation location: CGFloat, progress: CGFloat) {
        overlayView.alpha = progress
    }
    
    //animating alpha in case user just taps hamburger menu which directly change FrontViewPosition
    func revealController(_ revealController: SWRevealViewController!, animateTo position: FrontViewPosition) {
        
        //menu view is hidden
        if position == FrontViewPosition.left{
            overlayView.alpha = 0
        }
        
        //menu view is revealed
        if position == FrontViewPosition.right{
            overlayView.alpha = 1
        }
    }
    
}
