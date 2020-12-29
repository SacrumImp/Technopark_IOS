//
//  HomeViewController.swift
//  travel-note
//
//  Created by Алексей Савельев on 26.10.2020.
//

import UIKit
import FirebaseAuth
import GoogleMaps
import QuartzCore

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate{
    
    // MARK: Properties
    
    var viewModel: MapViewModelProtocol!{
        didSet{
            viewModel.currentLocationDidChange = { [weak self] currentLocation in
                guard let self = self else { return }
                let camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude), zoom: 17.0)
                self.mapView.camera = camera
            }
        }
    }
    
    private var mapView: GMSMapView!
    private var marker: GMSMarker!
    private var notesList = [Notes]()
    
    let testSettingsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 280, y: 80, width: 120, height: 35))
        button.setTitle("Настройки", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal) //красным чтоб заметно было
        button.layer.backgroundColor = UIColor.systemRed.cgColor.copy(alpha: 0.3)
        button.layer.cornerRadius = 8
        return button
    }()
    
    // перед появлением определяем на какой странице будет открыт tab bar
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.selectedIndex = Common.Settings.StartingHomePage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        mapView = getMapView()
        mapView.delegate = self
        view.addSubview(mapView)
        
        view.addSubview(testSettingsButton)
        testSettingsButton.addTarget(self, action: #selector(openSettings(sender:)), for: .touchUpInside)
        
        notesList = viewModel.getNotes()
        
        addNotesMarkers()
        
    }
    
    // MARK: Methods
    
    func getMapView() -> GMSMapView{
        
        let location = viewModel.currentLocation
        
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        
        return mapView
    }
    
    func addNotesMarkers(){
        for note in notesList{
            let position = CLLocationCoordinate2D(latitude: note.latitude, longitude: note.longitude)
            let marker = GMSMarker(position: position)
            marker.iconView = CustomMarkerInfoWindow(frame: CGRect(x: 0, y: 0, width: 100, height: 100), note: note)
            marker.map = mapView
        }
    }
    
    // MARK: GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        UIView.animate(withDuration: 1, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.testSettingsButton.transform = CGAffineTransform(translationX: 140, y: 0)
        })
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print("You get into 'idleAt' section")
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.testSettingsButton.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    
    // MARK: Buttons
    
    @objc func openSettings(sender: UIButton) {
        let settingsView = SettingsViewController()
        let navVC = UINavigationController(rootViewController: settingsView)
        navVC.modalTransitionStyle = .crossDissolve
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }
    
    // Mark: Delegate methods for custom marker
                
}

class CustomMarkerInfoWindow: UIView {
    
    var titleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var infoLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var imgView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    init(frame: CGRect, note: Notes) {
        super.init(frame: frame)
        backgroundColor = .red
        self.addSubview(imgView)
        imgView.image = UIImage(data: note.media)
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor, multiplier: 1).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 5
        imgView.layer.masksToBounds = true
        imgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        self.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 4).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8).isActive = true
        titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: centerYAnchor, constant: 2).isActive = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = UIColor.white
        titleLabel.text = note.title
        
        self.addSubview(infoLabel)
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        infoLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        infoLabel.textColor = UIColor.white
        infoLabel.text = note.info
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = 5
    }
}
