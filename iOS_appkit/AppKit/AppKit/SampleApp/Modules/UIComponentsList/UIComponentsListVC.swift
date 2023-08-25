//
//  UIComponentListVC.swift
//  AppKit
//
//  Created by Jyoti Luhana on 25/08/22.
//

import Foundation
import UIKit

class UIComponentsListVC: UIViewController {
    
    lazy var scrollView: UIScrollView = .init()
    
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fill
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var filledButton: UIButton = .init()
    lazy var filledWithIconButton: UIButton = .init()
    lazy var outlinedButton: UIButton = .init()
    lazy var outlinedWithIconButton: UIButton = .init()
    lazy var disabledFilledIconButton: UIButton = .init()
    lazy var disabledOutlinedIconButton: UIButton = .init()
    
    lazy var defaultTextInput: StatefulUITextfield = .init(withAppearances: AppArchitectureAppearance().defaultTextField, filledAppearance: AppArchitectureAppearance().filledTextField, typingAppearance: AppArchitectureAppearance().typingTextField, successAppearance: AppArchitectureAppearance().successTextField, errorAppearance: AppArchitectureAppearance().errorTextField)
    
    lazy var textfieldWithLeftIcon: StatefulUITextfield = .init(withAppearances: AppArchitectureAppearance().defaultLeftIconTextField, filledAppearance: AppArchitectureAppearance().filledLeftIconTextField, typingAppearance: AppArchitectureAppearance().typingLeftIconTextField, successAppearance: AppArchitectureAppearance().successLeftIconTextField, errorAppearance: AppArchitectureAppearance().errorLeftIconTextField)
    
    lazy var textfieldWithBothIcon: StatefulUITextfield = .init(withAppearances:AppArchitectureAppearance().defaultBothIconTextField, filledAppearance: AppArchitectureAppearance().filledBothIconTextField, typingAppearance: AppArchitectureAppearance().typingBothIconTextField, successAppearance: AppArchitectureAppearance().successBothIconTextField, errorAppearance: AppArchitectureAppearance().errorBothIconTextField)
    
    lazy var captionTextField: CaptionedUITextField = .init(withAppearances: AppArchitectureAppearance().defaultTextField, filledAppearance: AppArchitectureAppearance().filledTextField, typingAppearance: AppArchitectureAppearance().typingTextField, successAppearance: AppArchitectureAppearance().successTextField, errorAppearance: AppArchitectureAppearance().errorTextField)
    
    lazy var toggleSwitchOn: UISwitch = .init()
    lazy var toggleSwitchDisabled: UISwitch = .init()
    
    lazy var checkbox: UIButton = .init()
    
    lazy var contentDropdown: ContentDropdown = .init()
    lazy var listDropdown: ContentDropdown = .init()
    
    lazy var customNavigationBar: CustomNavigationBar = .init(titlePosition: .center)
    lazy var customBackNavigationBar: CustomNavigationBar = .init(titlePosition: .center)
    lazy var customLargeTitleNavigationBar: CustomNavigationBar = .init(titlePosition: .bottom)
    
    lazy var customAlertWithIcon: CustomAlert = .init(isIconAlert: true)
    lazy var customAlertDialog: CustomAlert = .init(isIconAlert: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViews()
        setupConstaints()
    }
    
    func setupUI() {
        
        self.view.backgroundColor = .systemBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        filledButton.translatesAutoresizingMaskIntoConstraints = false
        filledButton.setTitle("Button", for: .normal)
        filledButton.setAppearance(AppArchitectureAppearance().defaultButton)
        
        filledWithIconButton.translatesAutoresizingMaskIntoConstraints = false
        filledWithIconButton.setTitle("Button", for: .normal)
        filledWithIconButton.setAppearance(AppArchitectureAppearance().leftIconFilledButton)
        
        disabledFilledIconButton.translatesAutoresizingMaskIntoConstraints = false
        disabledFilledIconButton.setTitle("Button", for: .normal)
        var appearance = AppArchitectureAppearance().rightIconFilledButton
        appearance.textColor = .gray
        appearance.tintColor = .gray
        disabledFilledIconButton.isEnabled = false
        disabledFilledIconButton.setAppearance(appearance)
        
        outlinedButton.translatesAutoresizingMaskIntoConstraints = false
        outlinedButton.setTitle("Button", for: .normal)
        outlinedButton.setAppearance(AppArchitectureAppearance().outlinedButton)
        
        outlinedWithIconButton.translatesAutoresizingMaskIntoConstraints = false
        outlinedWithIconButton.setTitle("Button", for: .normal)
        outlinedWithIconButton.setAppearance(AppArchitectureAppearance().rightIconOutlinedButton)
        
        disabledOutlinedIconButton.translatesAutoresizingMaskIntoConstraints = false
        disabledOutlinedIconButton.setTitle("Button", for: .normal)
        var leftIconOutlinedButtonAppearance = AppArchitectureAppearance().leftIconOutlinedButton
        leftIconOutlinedButtonAppearance.textColor = .gray
        leftIconOutlinedButtonAppearance.tintColor = .gray
        leftIconOutlinedButtonAppearance.viewAppearance.borderColor = UIColor.gray.cgColor
        disabledOutlinedIconButton.setAppearance(leftIconOutlinedButtonAppearance)
        disabledOutlinedIconButton.isEnabled = false
        
        defaultTextInput.translatesAutoresizingMaskIntoConstraints = false
        defaultTextInput.setAppearance(AppArchitectureAppearance().defaultTextField)
        defaultTextInput.placeholder = "Placeholder text"
        
        textfieldWithLeftIcon.translatesAutoresizingMaskIntoConstraints = false
        textfieldWithLeftIcon.setAppearance(AppArchitectureAppearance().defaultLeftIconTextField)
        textfieldWithLeftIcon.placeholder = "Placeholder text"
        
        textfieldWithBothIcon.translatesAutoresizingMaskIntoConstraints = false
        textfieldWithBothIcon.setAppearance(AppArchitectureAppearance().defaultBothIconTextField)
        textfieldWithBothIcon.placeholder = "Placeholder text"
        
        captionTextField.translatesAutoresizingMaskIntoConstraints = false
        captionTextField.statefulTextfield.setAppearance(AppArchitectureAppearance().defaultTextField)
        captionTextField.statefulTextfield.placeholder = "Placeholder Text"
        captionTextField.captionLabel.text = "This is just a simple caption text!"
        
        toggleSwitchOn.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitchOn.isOn = true
        toggleSwitchOn.setAppearance(AppArchitectureAppearance().toggleSwitchOn)
        toggleSwitchOn.addTarget(self, action: #selector(didToggleSwitch(_:)), for: .touchUpInside)
        
        toggleSwitchDisabled.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitchDisabled.setAppearance(AppArchitectureAppearance().toggleSwitchOff)
        toggleSwitchDisabled.isEnabled = false
        
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.setTitle("Checkbox", for: .normal)
        checkbox.setAppearance(CheckboxAppearance.init(textColor: .blue, textAlignment: .left, buttonImage: UIImage(systemName: "checkmark.circle.fill"), tintColor: .blue))
     
        contentDropdown.translatesAutoresizingMaskIntoConstraints = false
        contentDropdown.titleButton.setTitle("Active dropdown", for: .normal)
        contentDropdown.titleButton.addTarget(self, action: #selector(didTapToggle), for: .touchUpInside)
        
        listDropdown.translatesAutoresizingMaskIntoConstraints = false
        listDropdown.titleButton.setTitle("List dropdown", for: .normal)
        listDropdown.titleButton.addTarget(self, action: #selector(didTapDisplayListOptions), for: .touchUpInside)
        
        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        customBackNavigationBar.setAppearance(CustomNavBarAppearance.init(leftIcon: UIImage(systemName: "line.3.horizontal"), rightIcon: UIImage(systemName: "person.circle")))
        
        customBackNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        customBackNavigationBar.setAppearance(CustomNavBarAppearance.init(title: "Title", leftIcon: UIImage(systemName: "chevron.left"), rightIcon: UIImage(systemName: "slider.vertical.3")))
        
        customLargeTitleNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        customLargeTitleNavigationBar.setAppearance(CustomNavBarAppearance.init(title: "Title", leftIcon: UIImage(systemName: "chevron.left"), rightIcon: UIImage(systemName: "slider.vertical.3")))
        
        customAlertWithIcon.translatesAutoresizingMaskIntoConstraints = false
        
        customAlertDialog.translatesAutoresizingMaskIntoConstraints = false
        customAlertDialog.setAppearance(CustomAlertAppearance.init(title: "Basic dialog title", textAlignment: .left, description: "A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made.", descriptionAlignment: .left, leftButtonTitle: "Button 2", rightButtonTitle: "Button 1"))
    }
    
    @objc func didToggleSwitch(_ sender: UISwitch) {
        if sender.isOn {
            toggleSwitchOn.setAppearance(AppArchitectureAppearance().toggleSwitchOn)
        } else {
            toggleSwitchOn.setAppearance(AppArchitectureAppearance().toggleSwitchOff)
        }
    }
    
    @objc func didTapToggle() {
        self.contentDropdown.toggleDropdown()
    }
    
    @objc func didTapDisplayListOptions() {
        let bottomSheet = BottomSheet()
        bottomSheet.modalPresentationStyle = .overFullScreen
        bottomSheet.okAction = { selected in
            self.listDropdown.titleButton.setTitle("Option \("\(selected ?? 0)")", for: .normal)
        }
        self.present(bottomSheet, animated: true)
    }
    
    func setupViews() {
        
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(scrollViewContainer)
        
        self.scrollViewContainer.addArrangedSubview(filledButton)
        self.scrollViewContainer.addArrangedSubview(filledWithIconButton)
        self.scrollViewContainer.addArrangedSubview(disabledFilledIconButton)
        self.scrollViewContainer.addArrangedSubview(outlinedButton)
        self.scrollViewContainer.addArrangedSubview(outlinedWithIconButton)
        self.scrollViewContainer.addArrangedSubview(disabledOutlinedIconButton)
        
        self.scrollViewContainer.addArrangedSubview(defaultTextInput)
        self.scrollViewContainer.addArrangedSubview(textfieldWithLeftIcon)
        self.scrollViewContainer.addArrangedSubview(textfieldWithBothIcon)
        self.scrollViewContainer.addArrangedSubview(captionTextField)
        
        self.scrollViewContainer.addArrangedSubview(toggleSwitchOn)
        self.scrollViewContainer.addArrangedSubview(toggleSwitchDisabled)

        self.scrollViewContainer.addArrangedSubview(checkbox)
        self.scrollViewContainer.addArrangedSubview(contentDropdown)
        self.scrollViewContainer.addArrangedSubview(listDropdown)

        self.scrollViewContainer.addArrangedSubview(customNavigationBar)
        self.scrollViewContainer.addArrangedSubview(customBackNavigationBar)
        self.scrollViewContainer.addArrangedSubview(customLargeTitleNavigationBar)
        
        self.scrollViewContainer.addArrangedSubview(customAlertWithIcon)
        self.scrollViewContainer.addArrangedSubview(customAlertDialog)
    }
    
    func setupConstaints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollViewContainer.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ])
        
        filledButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        filledButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        filledWithIconButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        filledWithIconButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        disabledFilledIconButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        disabledFilledIconButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        outlinedButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        outlinedButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        outlinedWithIconButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        outlinedWithIconButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        disabledOutlinedIconButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        disabledOutlinedIconButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        defaultTextInput.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        defaultTextInput.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        defaultTextInput.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        defaultTextInput.heightAnchor.constraint(equalToConstant: 50).isActive = true

        textfieldWithLeftIcon.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        textfieldWithLeftIcon.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        textfieldWithLeftIcon.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        textfieldWithLeftIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        textfieldWithBothIcon.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        textfieldWithBothIcon.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        textfieldWithBothIcon.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        textfieldWithBothIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true

        captionTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        captionTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        captionTextField.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        captionTextField.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        checkbox.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        checkbox.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        checkbox.heightAnchor.constraint(equalToConstant: 44).isActive = true

        contentDropdown.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        contentDropdown.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        contentDropdown.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        
        listDropdown.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        listDropdown.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        listDropdown.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        
        customNavigationBar.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        customNavigationBar.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        customNavigationBar.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        
        customBackNavigationBar.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        customBackNavigationBar.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        customBackNavigationBar.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        
        customLargeTitleNavigationBar.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        customLargeTitleNavigationBar.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        customLargeTitleNavigationBar.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        
        customAlertWithIcon.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        customAlertWithIcon.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        customAlertWithIcon.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        
        customAlertDialog.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        customAlertDialog.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        customAlertDialog.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
    }
}
