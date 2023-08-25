//
//  PersonalInfoUIView.swift
//  AppKit
//
//  Created by Jyoti Luhana on 08/09/22.
//

import UIKit

class PersonalInfoUIView: UIView {
    
    lazy var containerStackView: UIStackView = .init()
    
    lazy var titleStackView: UIStackView = .init()
    lazy var titleLabel: UILabel = .init()
    lazy var editButton: UIButton = .init()
    
    lazy var infoLabel: UILabel = .init()
    
    lazy var countLabel: UILabel = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.addConstraints()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        containerStackView.setAppearance(StackViewAppearance.init(axis: .vertical,
                                                                  spacing: 8,
                                                                  distribution: .fill,
                                                                  viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        //Title Header
        titleStackView.setAppearance(StackViewAppearance.init(axis: .horizontal,
                                                              spacing: 8,
                                                              distribution: .fill,
                                                              viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        titleLabel.setAppearance(LabelAppearance.init(text: "",
                                                      font: UIFont.systemFont(ofSize: 14),
                                                      viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        editButton.setAppearance(ButtonAppearance.init(buttonImage: UIImage(named: "edit_pencil"),
                                                       viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        editButton.imageView?.contentMode = .scaleAspectFit
        
        //User info
        infoLabel.setAppearance(LabelAppearance.init(numberOfLines: 0,
                                                     font: UIFont.systemFont(ofSize: 10),
                                                     viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
        
        countLabel.setAppearance(LabelAppearance.init(text: "",
                                                      textAlignment: .center,
                                                      font: UIFont.systemFont(ofSize: 14),
                                                      viewAppearance: ViewAppearance.init(backgroundColor: .clear)))
    }
    
    func setupViews() {
        self.addSubview(containerStackView)
            
        containerStackView.addArrangedSubview(titleStackView)
        containerStackView.addArrangedSubview(infoLabel)
        containerStackView.addArrangedSubview(countLabel)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(editButton)
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
     
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: containerStackView.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),
            titleStackView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

struct PersonalInfoViewAppearance {
    
    public init(title: String = "",
                infoDetail: String = "",
                count: String = "0",
                viewAppearance: ViewAppearance = ViewAppearance.init(backgroundColor: .white,
                                                                     cornerRadius: 10,
                                                                     shadowRadius: 4,
                                                                     shadowOpacity: 0.25,
                                                                     shadowOffset: CGSize(width: 0, height: 4),
                                                                     shadowColor: UIColor.init(red: 67/255, green: 24/255, blue: 255/255, alpha: 1).cgColor)) {
        
        self.title = title
        self.infoDetail = infoDetail
        self.count = "+\(count)"
        self.viewAppearance = viewAppearance
        
    }
    
    var viewAppearance: ViewAppearance = ViewAppearance.init(backgroundColor: .white,
                                                             cornerRadius: 10,
                                                             shadowRadius: 4,
                                                             shadowOpacity: 0.25,
                                                             shadowOffset: CGSize(width: 0, height: 4),
                                                             shadowColor: UIColor.init(red: 67/255, green: 24/255, blue: 255/255, alpha: 1).cgColor)
    var title: String = ""
    var infoDetail: String = ""
    var count: String = "0"
}

extension PersonalInfoUIView {
    
    func setAppearance(_ appearance: PersonalInfoViewAppearance) {
        
        self.titleLabel.text = appearance.title
        self.infoLabel.attributedText = NSAttributedString(string: appearance.infoDetail).withLineSpacing(10)
        self.countLabel.text = appearance.count
        
        setAppearance(appearance.viewAppearance)
    }
    
}
