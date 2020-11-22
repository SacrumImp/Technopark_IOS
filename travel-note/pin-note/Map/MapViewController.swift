//
//  HomeViewController.swift
//  travel-note
//
//  Created by Алексей Савельев on 26.10.2020.
//

import UIKit
import FirebaseAuth
import GoogleMaps

class MapViewController: UIViewController{
    
    var viewModel: MapViewModelProtocol!{didSet{}}
    
    let labelVC: UILabel = {
        let lable = UILabel(frame:CGRect(x: 0, y: 50, width: 300, height: 100))
        lable.text = "MapVC" //STRINGS:
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(getMapView())
        
        view.addSubview(labelVC)
        labelVC.center.x = self.view.center.x
        
    }
    
    func getMapView() -> UIView{
        
        let location = viewModel.getLocation()
        
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        marker.title = "Ваше местоположение" //STRINGS:
        marker.map = mapView
        
        return mapView
    }
    
}
