//
//  HomeView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2021/12/29.
//

import SwiftUI
import AudioToolbox
import GoogleMobileAds
import UserNotifications

struct HomeView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    var body: some View {
        
    ZStack{
        
        VStack {
            
            ZStack {
                
                if timeManager.isintarvalOn {
                    MainTimerHumanView()
                }

                ProgressBarView()
                    .opacity(timeManager.isProgressBarOn ? 1 : 0)

                if timeManager.timerStatus == .stopped {
                    PickerView()
                } else {
                    MainTimerCountdownIndicator()
                }
               

            }
          

            ZStack {
                
                IntervalTimerHumanView()
                    .opacity(timeManager.isintarvalOn ? 1 : 0)

                IntervalProgressBarView()
                    .opacity(timeManager.isProgressBarOn ? 1 : 0)
                    .opacity(timeManager.isintarvalOn ? 1 : 0)


                if timeManager.isintarvalOn {
                    switch timeManager.intervalTimerStatus {
                    case .intervalrunning, .intervalpause, .intervalset:
                        IntervalTimerCountdownIndicator()
                    case .intervalstopped:
                        IntervalPickerView()
                            .opacity(self.timeManager.timerStatus == .running ? 0 : 1)
                    }
                } else {
                    IntervalPickerView()
                        .opacity(timeManager.isintarvalOn ? 1 : 0)
                }
            }
            

            VStack {
                if timeManager.secSelection == 0 && timeManager.minSelection == 0 && timeManager.hourSelection == 0 {
                    Text("タイマーを設定してください")
                        .font(.caption)
                        .foregroundColor(.black)
                        .padding(.bottom,20)
                }  else if  timeManager.isintarvalOn  && timeManager.intervalsecSelection == 0 && timeManager.intervalminSelection == 0 && timeManager.intervalHourSelection == 0 && timeManager.countSelection == 0{
                    Text ("クールダウンを設定してください")
                        .font(.caption)
                        .foregroundColor(.black)
                        .padding(.bottom,20)
                } else if  timeManager.isintarvalOn  && timeManager.intervalsecSelection == 0 && timeManager.intervalminSelection == 0 && timeManager.intervalHourSelection == 0 && timeManager.countSelection >= 0{
                    Text ("インターバルを設定してください")
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .padding(.bottom,20)
                } else if timeManager.timerStatus == .running || timeManager.intervalTimerStatus == .intervalrunning {
                    Text ("一時停止は青いボタンを押してください")
                        .font(.caption)
                        .foregroundColor(Color.black)
                    Text ("リセットは赤い停止ボタンを押してください")
                        .font(.caption)
                        .foregroundColor(Color.black)

                } else if timeManager.timerStatus == .pause ||
                            timeManager.intervalTimerStatus == .intervalpause{
                    Text ("再スタートは緑の再生ボタンを押してください")
                        .font(.caption)
                        .foregroundColor(Color.black)
                    Text ("リセットは赤い停止ボタンを押してください")
                        .font(.caption)
                        .foregroundColor(Color.black)
                
                } else if timeManager.timerStatus == .stopped {
                    Text ("スタートボタンを押してください")
                        .font(.caption)
                        .foregroundColor(Color.black)
                   
                }
            }
            VStack {
                ZStack {
                    ButtonsView()
                }
                
                
                AdMobView()
                    .frame(width: 300, height: 50)
                
            }
           
           
        }
            if timeManager.timerStatus == .startcount {
               CountDownView()
            }
        
                
        }
        .onReceive(timeManager.timer) { _ in
            guard self.timeManager.timerStatus == .running else { return }
            if self.timeManager.duration > 0 {
                self.timeManager.duration -= 0.05
            } else {
                self.timeManager.timerStatus = .stopped
                if timeManager.isCountDownOn == false {
                    timeManager.isCountDownOn = true
                }
                
                if timeManager.intervalHourSelection != 0 || timeManager.intervalminSelection != 0 || timeManager.intervalsecSelection != 0 &&
                    timeManager.isintarvalOn || timeManager.countSelection != 0{
                    self.timeManager.setIntervalState(.intervalrunning)
                    
                    self.timeManager.setTimer()
                    
                    self.timeManager.makeNotification()
                    print("インターバルスタート")
                }
                if timeManager.isAlarmOn {
                    AudioServicesPlayAlertSoundWithCompletion(self.soundManager.soundID, nil)
                    
                   //soundManager.bgmplay()
                }
                if timeManager.isVibrationOn{
                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)){}
                }
            }
        }
        .onReceive(timeManager.intervaltimer){ _ in
            guard self.timeManager.intervalTimerStatus == .intervalrunning else {return}
            if self.timeManager.intervalDuration > 0 {
                self.timeManager.intervalDuration -= 0.05
            } else {
                self.timeManager.intervalTimerStatus = .intervalstopped
                if timeManager.isCountDownOn == false {
                    timeManager.isCountDownOn = true
                }
                if timeManager.countSelection == 0 || timeManager.isintarvalOn == false {
                    timeManager.reset()
                    timeManager.cooldownNotification()
                }
               else if timeManager.hourSelection != 0 || timeManager.minSelection != 0 || timeManager.secSelection != 0 ||
                    timeManager.isintarvalOn || timeManager.countSelection != 0{
                    self.timeManager.start()
                    self.timeManager.IntervalsetTimer()
                   self.timeManager.countSelection -= 1
                  
                    print("リスタート")
                   timeManager.intervalNotification()
                }
                if timeManager.isAlarmOn {
                    AudioServicesPlayAlertSoundWithCompletion(self.soundManager.soundID, nil)
                    //soundManager.bgmplay()
                }
                if timeManager.isVibrationOn {
                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)){}
                }
            }
        }
        .background {
            Image("Haikei")
                .resizable()
                .edgesIgnoringSafeArea(.top)
                .aspectRatio(contentMode:.fill)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())

    }
}

struct AdMobView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<AdMobView>) -> GADBannerView{
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        let request = GADRequest()
        request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene

        banner.adUnitID = "ca-app-pub-1648109753314876/4087495538"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(request)
        return banner
    }

    func updateUIView(_ uiView: GADBannerView, context:  UIViewRepresentableContext<AdMobView>) {
    }
}


