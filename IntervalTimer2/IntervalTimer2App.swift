//
//  IntervalTimer2App.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2021/12/27.
//

import SwiftUI
import UserNotifications
import GoogleMobileAds



@main
struct IntervalTimer2App: App {
    @StateObject private var timeManager: TimeManager = .init()
    @StateObject private var soundManager: SoundManager = .init()
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
       @Environment(\.scenePhase) private var scenePhase
       
       /*class AppDelegate: UIResponder, UIApplicationDelegate {
           
               func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                   return true
               }
       }*/
    init(){
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
    }
    
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timeManager)
                .environmentObject(soundManager)
        }
        .onChange(of:scenePhase){phase in
                   if phase == .background{
                       print(phase)
                   } else if phase == .inactive{
                       print(phase)
                   } else {
                       print(phase)
                   }
               }
           }
    }

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
            if granted {
                UNUserNotificationCenter.current().delegate = self
            }
        }
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([[.banner, .list, .sound]])
        }
}

