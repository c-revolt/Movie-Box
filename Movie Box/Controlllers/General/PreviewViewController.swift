//
//  PreviewViewController.swift
//  Movie Box
//
//  Created by Александр Прайд on 03.06.2022.
//

import UIKit
import WebKit

class PreviewViewController: UIViewController {
    
    private var titles: [Title] = [Title]()
    
    private let webView: WKWebView = {
        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addToListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add To List", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .systemGreen
        
        addSubiews()
        applyConstraints()
        
        addToListButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)

    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://youtube.com/embed/\(model.youtube.id.videoId)") else { return }
        
        webView.load(URLRequest(url: url))
    }
    
    private func addToList(indexPath: IndexPath) {
        
        DataPersistenceManager.shared.userBoxTitleWith(model: titles[indexPath.row]) { result in
                
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("Added"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    @objc func addButtonTapped(_ sender: UIButton) {
        
    }
    
    

}

//MARK: - Setup UI Elements
extension PreviewViewController {
    
    private func addSubiews() {
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(addToListButton)
    }
    
    private func applyConstraints() {
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            addToListButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 100),
            //addToListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addToListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            addToListButton.widthAnchor.constraint(equalToConstant: 140),
            addToListButton.heightAnchor.constraint(equalToConstant: 47)
        ])
        
    }
}
