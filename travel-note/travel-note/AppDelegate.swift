//
//  AppDelegate.swift
//  travel-note
//
//  Created by Владислав Алпеев on 17.10.2020.
//

import UIKit
import Firebase
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

//    private var splashPresenter: SplashPresenter? = SplashPresenter()
    
    var dictOfAPIs = [String: Dictionary<String, String>]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        getAPIs()
        
        FirebaseApp.configure()
        
        GMSServices.provideAPIKey(dictOfAPIs["GMSServices"]?["key"] ?? "0")
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func getAPIs(){
        guard let path = Bundle.main.path(forResource: "API", ofType: ".plist") else { return }
        guard let dictionary = NSDictionary(contentsOfFile: path) else { return }
        self.dictOfAPIs = dictionary as! [String : Dictionary<String, String>]
    }


}

