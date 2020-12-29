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
    
    let primaryColor = UIColor.red
    let secondaryColor = UIColor.blue
    
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
        var index = 1
        for note in notesList{
            let position = CLLocationCoordinate2D(latitude: note.latitude, longitude: note.longitude)
            marker = GMSMarker(position: position)
            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 50, height: 56), image: note.media, borderColor: primaryColor, tag: index)
            marker.iconView = customMarker
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0)
            marker.map = self.mapView
            marker.zIndex = Int32(index)
            marker.userData = note
            marker.map = mapView
            index += 1
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
    
    // MARK: Delegate methods for custom marker
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
        let img = customMarkerView.image
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 50, height: 56), image: img, borderColor: secondaryColor, tag: customMarkerView.tag)
        marker.iconView = customMarker
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
         if let note = marker.userData as? Notes {
            marker.tracksInfoWindowChanges = true
            let infoWindow = CustomMarkerInfoWindow()
            infoWindow.tag = 5555
            let height: CGFloat = 65
            let paddingWith = height + 16 + 32
            infoWindow.frame = CGRect(x: 0, y: 0, width: getEstimatedWidthForMarker(note, padding: paddingWith) + paddingWith, height: height)
            infoWindow.imgView.image = UIImage(data: note.media)
            infoWindow.titleLabel.text = note.title
            infoWindow.infoLabel.text = note.info
             return infoWindow
         }
         return nil
     }
     
     func getEstimatedWidthForMarker(_ note: Notes, padding: CGFloat) -> CGFloat {
         var estimatedWidth: CGFloat = 0
         let infoWindow = CustomMarkerInfoWindow()
         let maxWidth = (UIDevice.current.userInterfaceIdiom == .pad ? UIScreen.main.bounds.width * 0.7 : UIScreen.main.bounds.width * 0.8) - padding
         let titleWidth = (note.title).width(withConstrainedHeight: infoWindow.titleLabel.frame.height, font: infoWindow.titleLabel.font)
         let infoWidth = (note.info).width(withConstrainedHeight: infoWindow.infoLabel.frame.height, font: infoWindow.infoLabel.font)
         estimatedWidth = min(maxWidth, max(titleWidth, infoWidth))
         return estimatedWidth
     }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let img = customMarkerView.image
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 50, height: 56), image: img, borderColor: primaryColor, tag: customMarkerView.tag)
        marker.iconView = customMarker
    }
                
}

extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

class CustomMarkerView: UIView {
    
    var image: Data?
    var borderColor: UIColor!
    
    init(frame: CGRect, image: Data?, borderColor: UIColor, tag: Int) {
        super.init(frame: frame)
        self.image = image
        self.borderColor = borderColor
        self.tag = tag
        setupViews()
    }
    
    func setupViews() {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imgView)
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imgView.layer.cornerRadius = 25
        imgView.layer.borderColor = borderColor?.cgColor
        imgView.contentMode = .scaleAspectFill
        imgView.layer.borderWidth = 4
        imgView.clipsToBounds = true
        imgView.image = UIImage(data: image!)
        
        let triangleImgView = UIImageView()
        self.insertSubview(triangleImgView, belowSubview: imgView)
        triangleImgView.translatesAutoresizingMaskIntoConstraints = false
        triangleImgView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        triangleImgView.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -6).isActive = true
        triangleImgView.widthAnchor.constraint(equalToConstant: 23/2).isActive = true
        triangleImgView.heightAnchor.constraint(equalToConstant: 24/2).isActive = true
        triangleImgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        triangleImgView.image = UIImage(named: "markerTriangle")
        triangleImgView.tintColor = borderColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        self.addSubview(imgView)
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
        
        self.addSubview(infoLabel)
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        infoLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        infoLabel.textColor = UIColor.white
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
