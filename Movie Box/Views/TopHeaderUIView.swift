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
    
    private let addToList: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add To Box", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let trailerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.gray, for: .normal)
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
        addSubview(addToList)
        addSubview(trailerButton)
        trailerButton.addSubview(trailerLabel)
        trailerButton.addSubview(trailerButtonIcon)
        
        applyConctraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topImageView.frame = bounds
    }
    
    func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        
        
        topImageView.sd_setImage(with: url, completed: nil)
    }

}

// MARK: - Setup UI Elements
extension TopHeaderUIView {
    
    private func applyConctraints() {
        playButtonConstaints()
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
            addToList.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            addToList.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            addToList.widthAnchor.constraint(equalToConstant: 110),
            addToList.heightAnchor.constraint(equalToConstant: 47)
        ])
    }
    
    private func trailerButtonConstraints() {
        NSLayoutConstraint.activate([
            trailerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
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
