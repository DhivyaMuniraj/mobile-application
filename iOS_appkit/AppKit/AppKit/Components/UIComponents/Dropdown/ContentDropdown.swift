//
//  ContentDropdown.swift
//  AppKit
//
//  Created by Jyoti Luhana on 30/08/22.
//

import UIKit

// Inject description Label or tableView based on the requirement of the accordian

class ContentDropdown: UIView {
    
    lazy var containerStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 16
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var titleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Active dropdown", for: .normal)
        button.addImage(image: UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate), offset: 8, alignment: .right)
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0)
        return button
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = """
        Faucibus pulvinar elementum integer enim. In metus vulputate eu scelerisque felis imperdiet proin. Pulvinar etiam non quam lacus suspendise faucibus. Fusce ut placerat orci nulla pellentes.
        """
        return label
    }()
    
    var isDropdownExpanded: Bool = false

    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        self.backgroundColor = UIColor(displayP3Red: 244/255, green: 247/255, blue: 254/255, alpha: 1)
        self.layer.cornerRadius = 22

        self.addSubview(containerStack)
        self.containerStack.addArrangedSubview(titleButton)

        containerStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        containerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        containerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        containerStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
    }
    
    @objc func toggleDropdown() {
        if self.isDropdownExpanded {
            self.descriptionLabel.removeFromSuperview()
            titleButton.setTitleColor(.black, for: .normal)
        } else {
            self.containerStack.addArrangedSubview(descriptionLabel)
            self.layer.borderColor = UIColor.blue.cgColor
            titleButton.setTitleColor(.blue, for: .normal)
        }
        
        self.layer.borderWidth = isDropdownExpanded ? 0 : 1
        self.layer.cornerRadius = isDropdownExpanded ? 22 : 10
        self.backgroundColor = isDropdownExpanded ? UIColor(displayP3Red: 244/255, green: 247/255, blue: 254/255, alpha: 1) : .clear
        titleButton.tintColor = isDropdownExpanded ? .black : .blue
        
        self.isDropdownExpanded = !self.isDropdownExpanded

        self.layoutSubviews()
        self.layoutIfNeeded()
    }
}
