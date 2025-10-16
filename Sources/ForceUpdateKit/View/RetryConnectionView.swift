//
//  RetryConnectionView.swift
//  ForceUpdateKit
//
//  Created by Test Suite on 2024.
//

import Foundation
import UIKit
import ControlKitBase

public class RetryConnectionView: UIView {
    
    private var retryAction: (() -> Void)?
    private var dismissAction: (() -> Void)?
    var config: ForceUpdateViewConfig
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = config.retryContainerBackgroundColor
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        if let customImage = config.retryIconImage {
            imageView.image = customImage
        } else {
            imageView.image = ImageHelper.image(config.retryIconName)?.imageWithColor(color: config.retryIconColor)
        }
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = config.retryTitleText
        label.font = config.retryTitleFont
        label.textColor = config.retryTitleColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = config.retryMessageText
        label.font = config.retryMessageFont
        label.textColor = config.retryMessageColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(config.retryButtonTitle, for: .normal)
        button.setTitleColor(config.retryButtonTitleColor, for: .normal)
        button.backgroundColor = config.retryButtonBackgroundColor
        button.layer.cornerRadius = config.retryButtonCornerRadius
        button.titleLabel?.font = config.retryButtonFont
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    public init(config: ForceUpdateViewConfig, retryAction: @escaping () -> Void, dismissAction: (() -> Void)? = nil) {
        self.config = config
        self.retryAction = retryAction
        self.dismissAction = dismissAction
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backgroundView)
        addSubview(containerView)
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(retryButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Background view
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Container view - Full screen
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Icon - Center vertically
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -200),
            iconImageView.widthAnchor.constraint(equalToConstant: config.retryIconSize.width),
            iconImageView.heightAnchor.constraint(equalToConstant: config.retryIconSize.height),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 45),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            
            // Message
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            
            // Retry button
            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 60),
            retryButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
            retryButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            retryButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    @objc private func retryButtonTapped() {
        print("retryButtonTapped called")
        retryAction?()
    }
    
    
    public func show(in view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Animation - Fade in
        alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.alpha = 1
        }
    }
    
    public func hide() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
