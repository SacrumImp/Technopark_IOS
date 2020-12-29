//
//  ListNotes.swift
//  travel-note
//
//  Created by Владислав Алпеев on 01.11.2020.
//

import UIKit


class ListNotesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NoteLayoutDelegate {
    
    var viewModel: ListNotesViewModelProtocol!
    
    var notesList = [Notes]()
    
    private var theme = ThemeManager.currentTheme()
    
    private let testSettingsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 280, y: 80, width: 120, height: 35))
        button.setTitle("Настройки", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal) //красным чтоб заметно было
        button.layer.backgroundColor = UIColor.systemRed.cgColor.copy(alpha: 0.3)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var notesCollection: UICollectionView = {
        let layout = NoteLayout()
        var collection = UICollectionView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.size.width, height: (UIScreen.main.bounds.size.height - 150)), collectionViewLayout: layout)
        collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return collection
    }()
    
    private let labelVC: UILabel = {
        let lable = UILabel(frame:CGRect(x: -30, y: 50, width: 300, height: 100))
        lable.text = "Список заметок" //STRINGS:
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.textColor = .white
        lable.textAlignment = .center
        return lable
         }()
    
    override func viewWillAppear(_ animated: Bool) {
        ThemeManager.currentTheme()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = notesCollection.collectionViewLayout as? NoteLayout {
          layout.delegate = self
        }
        notesCollection.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        
        view.backgroundColor = theme.firstColor
        view.addSubview(testSettingsButton)
        testSettingsButton.addTarget(self, action: #selector(openSettings(sender:)), for: .touchUpInside)
        testSettingsButton.setTitleColor(theme.barButtons, for: .normal) //красным чтоб заметно было
        testSettingsButton.layer.backgroundColor = theme.thirdColor.cgColor.copy(alpha: 0.3)
        testSettingsButton.layer.borderColor = theme.mainColor.cgColor
        
        notesList = viewModel.getNotes()
        
        view.addSubview(notesCollection)
        notesCollection.register(NoteCell.self, forCellWithReuseIdentifier: "noteCell")
        notesCollection.delegate = self
        notesCollection.dataSource = self
        notesCollection.backgroundColor = theme.secondColor
        
        view.addSubview(labelVC)
        
        notesCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        notesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        notesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        notesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteCell", for: indexPath) as! NoteCell
        if notesList.isEmpty == false {
            print(notesList, indexPath.row)
            cell.photo.image = UIImage(data: notesList[indexPath.row].media)
            cell.titleLabel.text = notesList[indexPath.row].title
            cell.infoLabel.text = notesList[indexPath.row].info
        }
        notesCollection.layer.borderColor = UIColor.gray.cgColor
        cell.backgroundColor = theme.thirdColor
        cell.layer.cornerRadius = 16
        return cell
    }
    
    // нажатие на ячейку коллекции
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? NoteCell
        
        // создание алерта
        let alert = UIAlertController(title: "Удаление...", message: "Вы действительно хотите удалить заметку?", preferredStyle: UIAlertController.Style.actionSheet)

        // действия алерта
        alert.addAction(UIAlertAction(title: "Удалить", style: UIAlertAction.Style.destructive, handler: { action in
            collectionView.deleteItems(at: [indexPath])
            // TODO: удаление заметки из БД CoreData
            
        }))
        // действия алерта
        alert.addAction(UIAlertAction(title: "Редактировать", style: UIAlertAction.Style.default, handler: { action in
            
            var note = self.notesList[indexPath.row]
            let EditVC = AddNoteViewController(currentNote: note)
            let navVC = UINavigationController(rootViewController: EditVC)
            navVC.modalTransitionStyle = .crossDissolve
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))

        // вывод алерта
        self.present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
      return CGFloat(220)
    }
}

class NoteCell: UICollectionViewCell {
    fileprivate let photo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 12, weight: .bold)
        lable.textAlignment = .left
        return lable
    }()
    
    let infoLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 10, weight: .regular)
        lable.textAlignment = .left
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(photo)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        
        photo.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 157).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        titleLabel.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
        

        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
