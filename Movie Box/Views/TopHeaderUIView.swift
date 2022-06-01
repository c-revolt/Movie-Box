//
//  TopHeaderUIView.swift
//  Movie Box
//
//  Created by Александр Прайд on 30.05.2022.
//

import UIKit

class TopHeaderUIView: UIView {
    
    private let topImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "original")
        return imageView
    }()
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PLAY", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let trailerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        button.clipsToBounds = true
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let playButtonIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "play.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let trailerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "TRAILER"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let trailerButtonIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "film")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        createGradient()
        applyConctraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topImageView.frame = bounds
    }

}

// MARK: - Setup UI Elements
extension TopHeaderUIView {
    
    private func setupSubviews() {
        addSubview(topImageView)
        addSubview(playButton)
        playButton.addSubview(playButtonIcon)
        addSubview(trailerButton)
        trailerButton.addSubview(trailerLabel)
        trailerButton.addSubview(trailerButtonIcon)
    }
    
    private func applyConctraints() {
        playButtonConstaints()
        playButtonIconConstraints()
        trailerButtonConstraints()
        trailerButtonIconConstraints()
        trailerLabelConstraints()
    }
    
    private func createGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    private func playButtonConstaints() {
        
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            playButton.widthAnchor.constraint(equalToConstant: 110),
            playButton.heightAnchor.constraint(equalToConstant: 47)
        ])
    }
    
    private func playButtonIconConstraints() {
        
        NSLayoutConstraint.activate([
            playButtonIcon.topAnchor.constraint(equalTo: playButton.topAnchor, constant: 13),
            playButtonIcon.leadingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 15)
            
        ])
    }
    
    private func trailerButtonConstraints() {
        NSLayoutConstraint.activate([
            trailerButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 15),
            trailerButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            trailerButton.widthAnchor.constraint(equalToConstant: 110),
            trailerButton.heightAnchor.constraint(equalToConstant: 47)
        ])
    }
    
    private func trailerButtonIconConstraints() {
        
        NSLayoutConstraint.activate([
            trailerButtonIcon.topAnchor.constraint(equalTo: trailerButton.topAnchor, constant: 13),
            trailerButtonIcon.leadingAnchor.constraint(equalTo: trailerButton.leadingAnchor, constant: 5)
            
        ])
    }
    
    private func trailerLabelConstraints() {
        
        NSLayoutConstraint.activate([
            trailerLabel.topAnchor.constraint(equalTo: trailerButton.topAnchor, constant: 13),
            trailerLabel.trailingAnchor.constraint(equalTo: trailerButton.trailingAnchor, constant: -10)
        ])
    }
}
