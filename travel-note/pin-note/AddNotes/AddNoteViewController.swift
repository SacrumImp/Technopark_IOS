//
//  AddNoteViewController.swift
//  pin-note
//
//  Created by Алексей Савельев on 27.12.2020.
//

import UIKit

class AddNoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

// MARK: properties
    private let mainView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let titleLabel: UILabel = {
        let marginLeft = CGFloat(15)
        let lable = UILabel(frame:CGRect(x: marginLeft, y: 20, width: 150, height: 25))
        lable.text = "Название" //STRINGS:
        lable.font = .systemFont(ofSize: 15, weight: .bold)
        lable.textAlignment = .left
        return lable
    }()
    
    private var noteTitleField: UITextField = {
        var width = UIScreen.main.bounds.size.width
        let marginLeft = CGFloat(15)
        let textField =  UITextField(frame: CGRect(x: marginLeft, y: 50, width: width - (marginLeft*2), height: 45))
        // паддинг слева
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        textField.font = UIFont.systemFont(ofSize: 15)
        // рамка
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        // клавиатура и автокоррекция
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.backgroundColor = UIColor.lightGray
        return textField
    }()
    
    private let geoLabel: UILabel = {
        let marginLeft = CGFloat(15)
        let lable = UILabel(frame:CGRect(x: marginLeft, y: 100, width: 150, height: 25))
        lable.text = "Геометка" //STRINGS:
        lable.font = .systemFont(ofSize: 15, weight: .bold)
        lable.textAlignment = .left
        return lable
    }()
    
    private var geoField: UITextField = {
        var width = UIScreen.main.bounds.size.width
        let marginLeft = CGFloat(15)
        let textField =  UITextField(frame: CGRect(x: marginLeft, y: 130, width: width/2, height: 45))
        // паддинг слева
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 5, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        textField.font = UIFont.systemFont(ofSize: 15)
        // рамка
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1.0
        
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.backgroundColor = UIColor.gray
        
        textField.isEnabled = false
        return textField
    }()
    
    private let detailsLabel: UILabel = {
        let marginLeft = CGFloat(15)
        let lable = UILabel(frame:CGRect(x: marginLeft, y: 180, width: 150, height: 25))
        lable.text = "Примечание" //STRINGS:
        lable.font = .systemFont(ofSize: 15, weight: .bold)
        lable.textAlignment = .left
        return lable
    }()
    
    private var textView: UITextView = {
        var width = UIScreen.main.bounds.size.width
        var height = UIScreen.main.bounds.size.height
        let marginLeft = CGFloat(15)
        let marginTop = CGFloat(210)
        let textView = UITextView(frame: CGRect(x: marginLeft, y: marginTop, width: width - (marginLeft*2), height: (height/2)))
        textView.textAlignment = NSTextAlignment.justified
        textView.backgroundColor = UIColor.lightGray
        textView.isEditable = true
        
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = UIColor.black
        
        //textView.font = UIFont.boldSystemFont(ofSize: 15)
        textView.font = UIFont(name: "Verdana", size: 15)
        
        textView.isSelectable = true
        textView.dataDetectorTypes = UIDataDetectorTypes.link
        // рамка
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1.0
        
        // Автокорекция
        textView.autocorrectionType = UITextAutocorrectionType.yes
        textView.spellCheckingType = UITextSpellCheckingType.yes
        // myTextView.autocapitalizationType = UITextAutocapitalizationType.None
        
        return textView
    }()
// MARK: buttons
    let addGeoButton: UIButton = {
        var width = UIScreen.main.bounds.size.width
        let marginLeft = CGFloat(15)
        let marginTop = CGFloat(130)
        let button = UIButton(frame: CGRect(x: (marginLeft*2) + (width/2),
                                            y: marginTop,
                                            width: 45, height: 45))
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.layer.backgroundColor = UIColor.systemBlue.cgColor.copy(alpha: 0.5)
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    let addMediaButton: UIButton = {
        var width = UIScreen.main.bounds.size.width
        var height = UIScreen.main.bounds.size.height
        var buttonWidth = (UIScreen.main.bounds.size.width)/3
        let marginLeft = CGFloat(15)
        let marginTop = CGFloat(130)
        let button = UIButton(frame: CGRect(x: (width - buttonWidth - marginLeft),
                                            y: 210 + (height/2) + 7,
                                            width: buttonWidth, height: 35))
        button.setTitle("Добавить медиа", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(UIColor.green, for: .normal)
        button.layer.backgroundColor = UIColor.systemGreen.cgColor.copy(alpha: 0.5)
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitleField.delegate = self
        textView.delegate = self
        view.backgroundColor = .gray
        view.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(noteTitleField)
        mainView.addSubview(geoLabel)
        mainView.addSubview(geoField)
        mainView.addSubview(detailsLabel)
        mainView.addSubview(textView)
        mainView.addSubview(addGeoButton)
        mainView.addSubview(addMediaButton)
        //addMediaButton.addTarget(self, action: #selector(openSettings(sender:)), for: .touchUpInside)
        mainView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 1000)
        
        configureUI()
        
    }
// MARK: methods
    private func configureConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        
        constraints.append(titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 100))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureUI() {
        
        configureConstraints()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        navigationItem.title = "Новая заметка"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveNewNote))
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveNewNote() {
//        TODO: saving notes
    }
    
// MARK: textField delegate funcs
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        textField.layer.borderColor = UIColor.link.cgColor
        print("TextField should begin editing method called")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        textField.layer.borderColor = UIColor.gray.cgColor
        print("TextField should snd editing method called")
        return true
    }
// MARK: textView delegate funcs
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.layer.borderColor = UIColor.link.cgColor
        print("TextView should begin editing method called")
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.layer.borderColor = UIColor.gray.cgColor
        print("TextView should snd editing method called")
        return true
    }
}
