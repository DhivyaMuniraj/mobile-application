//
//  LoginVC.swift
//  AppKit
//
//  Created by Chaitanya Soni on 25/08/22.
//

import Foundation
import UIKit
import Combine

class LoginViewController: UIViewController {
    var viewModel: LoginViewModel
    var cancellables = Set<AnyCancellable>()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupListeners()
    }
    
    private func setupListeners() {
        let subscriber = viewModel.viewState.sink {[weak self] state in
            self?.render(state: state)
        }
        subscriber.store(in: &cancellables)
    }
    
    func render(state: LoginViewModel.LoginViewState?) {
        guard let state = state else { return }
        switch state {
        case .loading: renderLoading()
        case .loggedIn(let user): render(user: user)
        case .error(let error): render(error: error)
        }
    }
    
    func renderLoading() {
        self.loadingIndicator.isHidden = false
    }
    
    func render(error: Error) {
        self.loadingIndicator.isHidden = true
        // Show Error
    }
    
    func render(user: User) {
        self.loadingIndicator.isHidden = true
        self.viewModel.loginDidComplete(user: user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView: UIScrollView = .init()
    
    lazy var mainStackViewContainer: UIStackView = .init()
    
    lazy var cardStackViewContainer: UIStackView = .init()
    lazy var cardView: UIView = .init()
    
    lazy var containerStackViewContainer: UIStackView = .init()
    lazy var containerView: UIView = .init()
    
    lazy var emailTextField: StatefulUITextfield = .init(withAppearances: AppArchitectureAppearance().defaultLeftIconTextField,
                                                         filledAppearance: AppArchitectureAppearance().filledLeftIconTextField,
                                                         typingAppearance: AppArchitectureAppearance().typingLeftIconTextField,
                                                         successAppearance: AppArchitectureAppearance().successTextField,
                                                         errorAppearance: AppArchitectureAppearance().errorLeftIconTextField)
    
    lazy var passwordTextField: StatefulUITextfield = .init(withAppearances: AppArchitectureAppearance().defaultBothIconTextField,
                                                            filledAppearance: AppArchitectureAppearance().filledBothIconTextField,
                                                            typingAppearance: AppArchitectureAppearance().typingBothIconTextField,
                                                            successAppearance: AppArchitectureAppearance().successBothIconTextField,
                                                            errorAppearance: AppArchitectureAppearance().errorBothIconTextField)
	
    lazy var forgotPasswordButton: UIButton = .init()
    
    lazy var loginButton: UIButton = .init()
    
    lazy var orLabel: UILabel = .init()
    
    lazy var socialMediaContainerStackView: UIStackView = .init()
    
    lazy var googleLoginButton: UIButton = .init()
    
    lazy var facebookLoginButton: UIButton = .init()
    
    lazy var twitterLoginButton: UIButton = .init()
    
    lazy var loadingIndicator: UIActivityIndicatorView = .init()
    
    
    var userRequestsSignUpFlow: (() -> ())?
    var userRequestsForgotPasswordFlow: (() -> ())?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
        setupViews()
        addConstraints()
	}
	
	func setupUI() {
		
		self.view.backgroundColor = .systemBackground
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.mainStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        self.mainStackViewContainer.setAppearance(StackViewAppearance.init(alignment: .center,
                                                                           spacing: 40))

        self.containerStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        self.containerStackViewContainer.setAppearance(StackViewAppearance.init(alignment: .center,
                                                                           spacing: 20))
        
        self.cardStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        self.cardStackViewContainer.setAppearance(StackViewAppearance.init(alignment: .center,
                                                                           spacing: 20))
        
        self.cardView.setAppearance(ViewAppearance.init(backgroundColor: .white, cornerRadius: 20, shadowRadius: 8, shadowOpacity: 0.8, shadowOffset: CGSize(width: 0, height: 8), shadowColor: UIColor(displayP3Red: 67/255, green: 24/255, blue: 255/255, alpha: 0.25).cgColor, translatesAutoresizingMaskIntoConstraints: false))
        
        self.emailTextField.translatesAutoresizingMaskIntoConstraints = false
        var emailTextFieldAppearance = AppArchitectureAppearance().defaultLeftIconTextField
        emailTextFieldAppearance.leftImage = UIImage(systemName: "at")
        self.emailTextField.setAppearance(emailTextFieldAppearance)
        self.emailTextField.placeholder = "Enter email or username"
		
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        var passwordTextFieldAppearance = AppArchitectureAppearance().defaultBothIconTextField
        passwordTextFieldAppearance.leftImage = UIImage(systemName: "lock.shield")
        self.passwordTextField.setAppearance(passwordTextFieldAppearance)
        self.passwordTextField.placeholder = "Enter password"

        self.forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        self.forgotPasswordButton.addTarget(self, action: #selector(self.forgotPasswordButtonTapped), for: .touchUpInside)
        self.forgotPasswordButton.setAppearance(ButtonAppearance.init(textColor: UIColor(displayP3Red: 125/255, green: 125/255, blue: 125/255, alpha: 1), buttonTitle: "Forgot password?", font: UIFont.systemFont(ofSize: 10), contentHorizontalAlignment: .leading, highlightedColor: .clear))
        
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.setAppearance(AppArchitectureAppearance().defaultButton)
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.addTarget(self, action: #selector(self.LoginButtonTapped), for: .touchUpInside)
        
        self.orLabel.translatesAutoresizingMaskIntoConstraints = false
        self.orLabel.setAppearance(LabelAppearance.init(textColor: UIColor(displayP3Red: 73/255, green: 69/255, blue: 79/255, alpha: 1), textAlignment: .center, font: UIFont.systemFont(ofSize: 12)))
        self.orLabel.text = "OR"
        
        self.socialMediaContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        self.socialMediaContainerStackView.setAppearance(StackViewAppearance.init(axis: .horizontal,
                                                                           alignment: .center,
                                                                           spacing: 20, distribution: .equalSpacing))
        
        self.googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.googleLoginButton.setAppearance(ButtonAppearance.init(buttonImage: UIImage(named: "google"), viewAppearance: ViewAppearance.init(backgroundColor: .white, cornerRadius: 23, shadowRadius: 4, shadowOpacity: 0.8, shadowOffset: CGSize(width: 0, height: 3), shadowColor: UIColor(displayP3Red: 67/255, green: 24/255, blue: 255/255, alpha: 0.15).cgColor)))
        
        self.facebookLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.facebookLoginButton.setAppearance(ButtonAppearance.init(buttonImage: UIImage(named: "facebook"), viewAppearance: ViewAppearance.init(backgroundColor: .white, cornerRadius: 23, shadowRadius: 4, shadowOpacity: 0.8, shadowOffset: CGSize(width: 0, height: 3), shadowColor: UIColor(displayP3Red: 67/255, green: 24/255, blue: 255/255, alpha: 0.15).cgColor)))
        
        self.twitterLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.twitterLoginButton.setAppearance(ButtonAppearance.init(buttonImage: UIImage(named: "twitter"), viewAppearance: ViewAppearance.init(backgroundColor: .white, cornerRadius: 23, shadowRadius: 4, shadowOpacity: 0.8, shadowOffset: CGSize(width: 0, height: 3), shadowColor: UIColor(displayP3Red: 67/255, green: 24/255, blue: 255/255, alpha: 0.15).cgColor)))
        self.loadingIndicator.startAnimating()
        self.loadingIndicator.isHidden = true
        self.loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
	}
    
    @objc func forgotPasswordButtonTapped() {
        self.viewModel.forgotPasswordAction()
    }
    
    @objc func LoginButtonTapped() {
        self.viewModel.loginAction()
    }
    
    func setupViews() {
        
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(cardStackViewContainer)
        self.cardStackViewContainer.addArrangedSubview(cardView)
        
        self.cardView.addSubview(mainStackViewContainer)
        
        self.mainStackViewContainer.addArrangedSubview(containerView)
        self.mainStackViewContainer.addArrangedSubview(orLabel)
        self.mainStackViewContainer.addArrangedSubview(socialMediaContainerStackView)
        
        self.containerView.addSubview(containerStackViewContainer)
        
        self.containerStackViewContainer.addArrangedSubview(emailTextField)
        self.containerStackViewContainer.addArrangedSubview(passwordTextField)
        self.containerStackViewContainer.addArrangedSubview(forgotPasswordButton)
        self.containerStackViewContainer.addArrangedSubview(loginButton)
        
        self.socialMediaContainerStackView.addArrangedSubview(googleLoginButton)
        self.socialMediaContainerStackView.addArrangedSubview(facebookLoginButton)
        self.socialMediaContainerStackView.addArrangedSubview(twitterLoginButton)
        self.view.addSubview(loadingIndicator)
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cardStackViewContainer.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -50),
            cardStackViewContainer.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: cardStackViewContainer.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: cardStackViewContainer.trailingAnchor),
            cardView.topAnchor.constraint(equalTo: cardStackViewContainer.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: cardStackViewContainer.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            mainStackViewContainer.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 40),
            mainStackViewContainer.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: -40),
            mainStackViewContainer.topAnchor.constraint(equalTo: self.cardView.topAnchor, constant: 40),
            mainStackViewContainer.bottomAnchor.constraint(equalTo: self.cardView.bottomAnchor, constant: -40),
            mainStackViewContainer.centerYAnchor.constraint(equalTo: self.cardView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.mainStackViewContainer.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.mainStackViewContainer.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: self.containerStackViewContainer.heightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            containerStackViewContainer.leadingAnchor.constraint(equalTo: self.mainStackViewContainer.leadingAnchor),
            containerStackViewContainer.trailingAnchor.constraint(equalTo: self.mainStackViewContainer.trailingAnchor),
            
            orLabel.leadingAnchor.constraint(equalTo: self.mainStackViewContainer.leadingAnchor),
            orLabel.trailingAnchor.constraint(equalTo: self.mainStackViewContainer.trailingAnchor),
            orLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            self.emailTextField.leadingAnchor.constraint(equalTo: self.containerStackViewContainer.leadingAnchor),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.containerStackViewContainer.trailingAnchor),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.containerStackViewContainer.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.containerStackViewContainer.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            self.forgotPasswordButton.widthAnchor.constraint(equalTo: self.containerStackViewContainer.widthAnchor),
            
            self.loginButton.widthAnchor.constraint(equalTo: self.containerStackViewContainer.widthAnchor),
            self.loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            self.socialMediaContainerStackView.leadingAnchor.constraint(equalTo: self.mainStackViewContainer.leadingAnchor, constant: 30),
            self.socialMediaContainerStackView.trailingAnchor.constraint(equalTo: self.mainStackViewContainer.trailingAnchor, constant: -30)
        ])
            
        NSLayoutConstraint.activate([
            self.googleLoginButton.widthAnchor.constraint(equalToConstant: 46),
            self.googleLoginButton.heightAnchor.constraint(equalToConstant: 46),
            
            self.facebookLoginButton.widthAnchor.constraint(equalToConstant: 46),
            self.facebookLoginButton.heightAnchor.constraint(equalToConstant: 46),
            
            self.twitterLoginButton.widthAnchor.constraint(equalToConstant: 46),
            self.twitterLoginButton.heightAnchor.constraint(equalToConstant: 46),
            
            self.loadingIndicator.widthAnchor.constraint(equalToConstant: 50),
            self.loadingIndicator.heightAnchor.constraint(equalToConstant: 50),
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
