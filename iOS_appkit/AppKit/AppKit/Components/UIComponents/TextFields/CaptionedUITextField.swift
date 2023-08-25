//
//  CaptionedUITextField.swift
//  AppKit
//
//  Created by Jyoti Luhana on 30/08/22.
//

import UIKit

class CaptionedUITextField: UIView {
    
    lazy var containerStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 8
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    
    lazy var statefulTextfield: StatefulUITextfield = {
        let textfield = StatefulUITextfield.init(withAppearances: AppArchitectureAppearance().defaultTextField, filledAppearance: AppArchitectureAppearance().filledTextField, typingAppearance: AppArchitectureAppearance().typingTextField, successAppearance: AppArchitectureAppearance().successTextField, errorAppearance: AppArchitectureAppearance().errorTextField)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    

    init(withAppearances defaultAppearance: TextFieldAppearance, filledAppearance: TextFieldAppearance, typingAppearance: TextFieldAppearance, successAppearance: TextFieldAppearance, errorAppearance: TextFieldAppearance) {
        super.init(frame: .zero)
        self.statefulTextfield = .init(withAppearances: defaultAppearance, filledAppearance: filledAppearance, typingAppearance: typingAppearance, successAppearance: successAppearance, errorAppearance: errorAppearance)
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        self.addSubview(containerStack)
        
        self.containerStack.addArrangedSubview(statefulTextfield)
        self.containerStack.addArrangedSubview(captionLabel)
        
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: self.topAnchor),
            containerStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

public struct CaptionedUITextFieldAppearance {
    
    public init() {

    }
 
}

extension CaptionedUITextField {
    
    func setAppearance(_ appearance: CaptionedUITextFieldAppearance) {
        
    }
}
