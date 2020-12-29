//
//  ListNotes.swift
//  travel-note
//
//  Created by Владислав Алпеев on 01.11.2020.
//

import UIKit

class ListNotesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var viewModel: ListNotesViewModelProtocol!
    
    var notesList = [Notes]()
    
    private let testSettingsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 280, y: 80, width: 120, height: 35))
        button.setTitle("Настройки", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal) //красным чтоб заметно было
        button.layer.backgroundColor = UIColor.systemRed.cgColor.copy(alpha: 0.3)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let mainView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private var notesCollection: UICollectionView = {
        var width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let marginLeft = CGFloat(15)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var collection = UICollectionView(frame: CGRect(x: marginLeft, y: 289 + (height/2), width: width - (marginLeft*2), height: 120), collectionViewLayout: layout)
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5, height: 2.0))
        collection.register(NoteCell.self, forCellWithReuseIdentifier: "noteCell")
        collection.backgroundColor = .lightGray
        collection.layer.cornerRadius = 5
        collection.layer.borderColor = UIColor.lightGray.cgColor
        collection.layer.borderWidth = 1.0
        collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(testSettingsButton)
        testSettingsButton.addTarget(self, action: #selector(openSettings(sender:)), for: .touchUpInside)
        
        notesList = viewModel.getNotes()
        
        view.addSubview(mainView)
        mainView.addSubview(notesCollection)
        notesCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        notesCollection.delegate = self
        notesCollection.dataSource = self
        mainView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: mainView.bounds.size.height)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func openSettings(sender: UIButton) {
        let settingsView = SettingsViewController()
        let navVC = UINavigationController(rootViewController: settingsView)
        navVC.modalTransitionStyle = .crossDissolve
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }
    
    // MARK: collectionView delegate funcs
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteCell", for: indexPath) as! NoteCell
        cell.photo.image = UIImage(data: notesList[indexPath.row].media)
        cell.titleLabel.text = notesList[indexPath.row].title
        notesCollection.layer.borderColor = UIColor.gray.cgColor
        return cell
    }

}

class NoteCell: UICollectionViewCell {
    fileprivate let photo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let marginLeft = CGFloat(15)
        let lable = UILabel(frame:CGRect(x: marginLeft, y: 20, width: 150, height: 25))
        lable.font = .systemFont(ofSize: 15, weight: .bold)
        lable.textAlignment = .left
        return lable
    }()
    
    let infoLabel: UILabel = {
        let marginLeft = CGFloat(15)
        let lable = UILabel(frame:CGRect(x: marginLeft, y: 20, width: 150, height: 25))
        lable.font = .systemFont(ofSize: 15, weight: .bold)
        lable.textAlignment = .left
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(photo)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        photo.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photo.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        photo.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: photo.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

