//
//  SideMenuViewController.swift
//  AppKit
//
//  Created by Jyoti Luhana on 15/09/22.
//

import Foundation
import UIKit

class SideMenuViewController: UIViewController {
    
    lazy var tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    
    lazy var menuTitleLabel: UILabel = .init()
    lazy var menuTitleView: UIView = .init()
    
    var sideMenuData = [
        (header: "Seaction Header 1", data: [
            (icon: "circle.fill", title: "Label 1", detailsLabel: "100+"),
            (icon: "square.fill", title: "Label 2", detailsLabel: ""),
            (icon: "triangle.fill", title: "Label 3", detailsLabel: ""),
            (icon: "pentagon.fill", title: "Label 4", detailsLabel: "")
        ]),
        
        (header: "Seaction Header 2", data: [
            (icon: "circle.fill", title: "Label 5", detailsLabel: ""),
            (icon: "square.fill", title: "Label 6", detailsLabel: ""),
            (icon: "triangle.fill", title: "Label 7", detailsLabel: "")
        ]),
        
        (header: "Seaction Header 3", data: [
            (icon: "circle.fill", title: "Label 8", detailsLabel: ""),
            (icon: "square.fill", title: "Label 9", detailsLabel: ""),
            (icon: "triangle.fill", title: "Label 10", detailsLabel: "")
        ])
    ]
    
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0) {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.setupViews()
        self.addConstraints()
        self.setupUI()
    }
    
    func setupUI() {
        
        menuTitleLabel.setAppearance(LabelAppearance.init(text: "Title",
                                                          font: UIFont.boldSystemFont(ofSize: 16),
                                                          viewAppearance: ViewAppearance.init(backgroundColor: .white)))
        
        menuTitleView.setAppearance(ViewAppearance.init(backgroundColor: .white))
        
        tableView.setAppearance(ViewAppearance.init(backgroundColor: .white))
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SideMenuItemCell.self, forCellReuseIdentifier: "SideMenuItemCell")
    }
    
    func setupViews() {
        
        self.view.addSubview(tableView)
        self.view.addSubview(menuTitleView)
        self.menuTitleView.addSubview(menuTitleLabel)
        
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            menuTitleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            menuTitleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            menuTitleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            menuTitleView.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        NSLayoutConstraint.activate([
            menuTitleLabel.leadingAnchor.constraint(equalTo: self.menuTitleView.leadingAnchor, constant: 22),
            menuTitleLabel.trailingAnchor.constraint(equalTo: self.menuTitleView.trailingAnchor, constant: -20),
            menuTitleLabel.centerYAnchor.constraint(equalTo: menuTitleView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -58),
            tableView.topAnchor.constraint(equalTo: self.menuTitleView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}


extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sideMenuData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuData[section].data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuItemCell", for: indexPath) as? SideMenuItemCell
        cell?.selectionStyle = .none
        cell?.isSelected = indexPath == selectedIndexPath
        cell?.selectedData = sideMenuData[indexPath.section].data[indexPath.row]
        cell?.setupUI()
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SideMenuHeaderCell()
        view.headerLabel.text = sideMenuData[section].header
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = SideMenuFooterCell()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
