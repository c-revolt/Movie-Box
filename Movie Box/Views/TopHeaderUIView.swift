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
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.clipsToBounds = true
        label.layer.cornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let inABoxButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGreen
        button.clipsToBounds = true
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let inABoxButtonIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus.square")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let inABoxButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "IN A BOX"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    private let trailerButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.borderWidth = 2
        button.clipsToBounds = true
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let trailerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "TRAILER"
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let trailerButtonIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "film")
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(topImageView)
        createGradient()
        addSubview(titleLabel)
        addSubview(voteAverageLabel)
        addSubview(inABoxButton)
        inABoxButton.addSubview(inABoxButtonIcon)
        inABoxButton.addSubview(inABoxButtonLabel)
        addSubview(trailerButton)
        trailerButton.addSubview(trailerLabel)
        trailerButton.addSubview(trailerButtonIcon)
        
        applyConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topImageView.frame = bounds
    }
    
    func configure(with model: TitleViewModel) {
        
        DispatchQueue.main.async {
            self.titleLabel.text = model.titleName
            self.voteAverageLabel.text = String(model.rate)
        }
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        
        topImageView.sd_setImage(with: url, completed: nil)
        
        
    }

}

// MARK: - Setup UI Elements
extension TopHeaderUIView {
    
    private func createGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    

        
    private func applyConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            voteAverageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            voteAverageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            voteAverageLabel.widthAnchor.constraint(equalToConstant: 47),
            voteAverageLabel.heightAnchor.constraint(equalToConstant: 47)
        ])
        
        NSLayoutConstraint.activate([
            inABoxButton.leadingAnchor.constraint(equalTo: trailerButton.trailingAnchor, constant: 10),
            inABoxButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            inABoxButton.widthAnchor.constraint(equalToConstant: 110),
            inABoxButton.heightAnchor.constraint(equalToConstant: 47)
        ])
        
        NSLayoutConstraint.activate([
            inABoxButtonIcon.topAnchor.constraint(equalTo: inABoxButton.topAnchor, constant: 13),
            inABoxButtonIcon.leadingAnchor.constraint(equalTo: inABoxButton.leadingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            inABoxButtonLabel.topAnchor.constraint(equalTo: inABoxButton.topAnchor, constant: 13),
            inABoxButtonLabel.trailingAnchor.constraint(equalTo: inABoxButton.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            trailerButton.leadingAnchor.constraint(equalTo: voteAverageLabel.trailingAnchor, constant: 10),
            trailerButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            trailerButton.widthAnchor.constraint(equalToConstant: 110),
            trailerButton.heightAnchor.constraint(equalToConstant: 47)
        ])
        
        NSLayoutConstraint.activate([
            trailerButtonIcon.topAnchor.constraint(equalTo: trailerButton.topAnchor, constant: 13),
            trailerButtonIcon.leadingAnchor.constraint(equalTo: trailerButton.leadingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            trailerLabel.topAnchor.constraint(equalTo: trailerButton.topAnchor, constant: 13),
            trailerLabel.trailingAnchor.constraint(equalTo: trailerButton.trailingAnchor, constant: -10)
        ])
        
    }
    
}
