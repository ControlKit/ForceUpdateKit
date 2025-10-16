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
    private var config: ForceUpdateViewConfig
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = config.retryBackgroundColor
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = config.retryContainerBackgroundColor
        view.layer.cornerRadius = config.retryContainerCornerRadius
        view.layer.masksToBounds = true
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
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(config.dismissButtonTitle, for: .normal)
        button.setTitleColor(config.dismissButtonTitleColor, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = config.dismissButtonFont
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
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
        containerView.addSubview(dismissButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Background view
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Container view
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            // Icon
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: config.retryIconSize.width),
            iconImageView.heightAnchor.constraint(equalToConstant: config.retryIconSize.height),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            // Message
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            // Retry button
            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            retryButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            retryButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            retryButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Dismiss button
            dismissButton.topAnchor.constraint(equalTo: retryButton.bottomAnchor, constant: 8),
            dismissButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            dismissButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            dismissButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func retryButtonTapped() {
        retryAction?()
    }
    
    @objc private func dismissButtonTapped() {
        dismissAction?()
        removeFromSuperview()
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
        
        // Animation
        alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
            self.alpha = 1
            self.containerView.transform = .identity
        }
    }
    
    public func hide() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
