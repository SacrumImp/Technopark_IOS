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

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    let lableVC: UILabel = {
        let lable = UILabel(frame:CGRect(x: 0, y: 50, width: 130, height: 35))
        lable.text = "MapVC" //STRINGS:
        lable.font = .systemFont(ofSize: 32, weight: .bold)
        lable.textAlignment = .center
        lable.layer.backgroundColor = UIColor.systemGreen.cgColor.copy(alpha: 0.3)
        lable.layer.cornerRadius = 10
        return lable
    }()
    
    let testSettingsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 280, y: 50, width: 120, height: 35))
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
        
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        view.addSubview(getMapView())
        
        view.addSubview(lableVC)
        lableVC.center.x = self.view.center.x
        
        view.addSubview(testSettingsButton)
        testSettingsButton.addTarget(self, action: #selector(openSettings(sender:)), for: .touchUpInside)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
    }
    
    func getMapView() -> UIView{
        let latitude = 55.75
        let longitude = 37.62
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "Ваше местоположение" //STRINGS:
        marker.map = mapView
        
        return mapView
    }
    
    @objc func openSettings(sender: UIButton) {
        let settingsView = SettingsView()
        let navVC = UINavigationController(rootViewController: settingsView)
        navVC.modalTransitionStyle = .crossDissolve
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }
    
    // оставлю пока следующее:
    func startAuth() {
        let authentificationViewModel = AuthentificationViewModel()
        let authentificationView = Authentication_Phone()
        authentificationView.viewModel = authentificationViewModel
        authentificationView.modalTransitionStyle = .coverVertical
        authentificationView.modalPresentationStyle = .automatic
        self.present(authentificationView, animated: true)
    }

}
