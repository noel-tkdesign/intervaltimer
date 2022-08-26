//
//  TimerManager.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2021/12/27.
//

import AVFoundation
import AudioToolbox
import Combine
import SwiftUI

// MARK: - TimeManager
final class TimeManager: ObservableObject {

    // MARK: Properties
    @Published var hourSelection: Int = 0
    @Published var minSelection: Int = 0
    @Published var secSelection: Int = 0
    @Published var countSelection: Int = 0
    @Published var countPicker = [Int](1..<21)
    @Published var intervalHourSelection: Int = 0
    @Published var intervalminSelection: Int = 0
    @Published var intervalsecSelection: Int = 0
    @Published var duration: Double = 0
    @Published var maxValue: Double = 0
    @Published var intervalDuration: Double = 0
    @Published var intervalMaxValue: Double = 0
    @Published var displayedTimeFormat: TimerFormat = .min
    @Published var intervalDisplayedTimeFormat: IntervalTimerFormat = .intervalmin
    @Published var timerStatus: TimerStatus = .stopped
    @Published var intervalTimerStatus: IntervalTimerStatus = .intervalstopped
    @Published var isAlarmOn: Bool = true
    @Published var isVibrationOn: Bool = true
    @Published var isintarvalOn: Bool = true
    @Published var isProgressBarOn: Bool = true
    @Published var isCountDownOn: Bool = true
    @Published var isMainCountDown: Bool = true
    @Published var isEffectAnimationOn: Bool = true
    @Published var isSetting: Bool = false
    var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    var intervaltimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    var cancellables: Set<AnyCancellable> = .init()

    // MARK: Initializer
    // Initializer とは、なぜ必要？
   /* init() {
        timer.sink { [weak self] _ in
            
        }
        .store(in: &cancellables)
    } */

    // MARK: Methods
    func setTimer() {
        duration = Double(hourSelection * 3600 + minSelection * 60 + secSelection)
        maxValue = duration
        
        timerStatus = .set
        
        if duration < 60 {
            displayedTimeFormat = .sec
        } else if duration < 3600 {
            displayedTimeFormat = .min
        } else {
            displayedTimeFormat = .hr
        }
    }

    func displayTimer() -> String {
        let hr = Int(duration) / 3600
        let min = Int(duration) % 3600 / 60
        let sec = Int(duration) % 3600 % 60
        
        switch displayedTimeFormat {
        case.hr: return String(format: "%02d:%02d:%02d", hr,min,sec)
        case.min: return String(format: "%02d:%02d", min, sec)
        case.sec: return String(format: "%02d", sec)
            
        }
    }
    func set() {
        timerStatus = .set
    }

    func start() {
        timerStatus = .running
    }

    func pause() {
        timerStatus = .pause
    }

    func reset() {
        timerStatus = .stopped
        intervalTimerStatus = .intervalstopped
        duration = 0
    }
    func StartCount() {
        timerStatus = .startcount
    }
    func intervalStart() {
        intervalTimerStatus = .intervalrunning
    }
    
    func IntervalPause(){
        intervalTimerStatus = .intervalpause
        countSelection -= 1
    }
    
    func Intervalreset(){
        intervalTimerStatus = .intervalstopped
        intervalDuration = 0
    }
    
    func IntervalsetTimer() {
        intervalDuration = Double(intervalHourSelection * 3600
                                  + intervalminSelection * 60
                                  + intervalsecSelection)
        intervalMaxValue = intervalDuration

        // ここを追加
      
        intervalTimerStatus = .intervalset
        
       
        if intervalDuration < 60 {
            intervalDisplayedTimeFormat = .intervalsec
        } else if intervalDuration < 3600 {
            intervalDisplayedTimeFormat = .intervalmin
        } else {
            intervalDisplayedTimeFormat = .intervalhr
        }
    }

    func IntervalDisplayTimer() -> String {
        let hr = Int(intervalDuration) / 3600
        let min = Int(intervalDuration) % 3600 / 60
        let sec = Int(intervalDuration) % 3600 % 60
        
        switch intervalDisplayedTimeFormat {
        case.intervalhr: return String(format: "%02d:%02d:%02d", hr,min,sec)
        case.intervalmin: return String(format: "%02d:%02d", min, sec)
        case.intervalsec: return String(format: "%02d", sec)
            
        }
    }
    
    func setIntervalState(_ status: IntervalTimerStatus) {
        intervalTimerStatus = status
        if status == .intervalstopped {
            intervalDuration = 0.0
        }
    }
    func Count() {
        while countSelection >= 0 && intervalTimerStatus == .intervalstopped {
            countSelection -= 1
        }
    }
    
    func makeNotification(){
            //②通知タイミングを指定
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            
            //③通知コンテンツの作成
            let content = UNMutableNotificationContent()
            content.title = "メインタイマー終了"
            content.body = (countSelection == 0 ? "クールダウンです！！息を整えましょう" : "インターバルです！！息を整えてトレーニングまで待ちましょう")
            content.sound = UNNotificationSound.default
            
            //④通知タイミングと通知内容をまとめてリクエストを作成。
            let request = UNNotificationRequest(identifier: "notification001", content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }

    func intervalNotification(){
            //②通知タイミングを指定
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            
            //③通知コンテンツの作成
            let content = UNMutableNotificationContent()
            content.title = "インターバルタイマー終了"
            content.body = "トレーニングです！！頑張りましょう"
            content.sound = UNNotificationSound.default
            
            //④通知タイミングと通知内容をまとめてリクエストを作成。
            let request = UNNotificationRequest(identifier: "notification001", content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }

    func cooldownNotification(){
            //②通知タイミングを指定
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            
            //③通知コンテンツの作成
            let content = UNMutableNotificationContent()
            content.title = "クールダウン終了"
            content.body = "トレーニングが終了しました！！お疲れ様でした"
            content.sound = UNNotificationSound.default
            
            //④通知タイミングと通知内容をまとめてリクエストを作成。
            let request = UNNotificationRequest(identifier: "notification001", content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }

    
}
