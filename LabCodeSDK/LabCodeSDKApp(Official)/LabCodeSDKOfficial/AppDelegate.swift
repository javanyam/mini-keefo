
import UIKit

// 1. 'LabCodeSDK'를 Import합니다.
import LabCodeSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 2. SDK 로그인
        LabCodeSDK.LoginManager.shared.labcode(
            apiKey: "Insert your apikey.",
            apiSecret: "Insert your apiSecret.",
            completion: { result in
                // 2-1. 로그인에 성공했을 때와 실패했을 때를 나누어 행동할 수 있습니다.
                if result == .success {
                     
                } else {
                
                }
            }
        )
       
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
}

