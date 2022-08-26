//
//  SettingView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/01/05.
//

import SwiftUI


struct SettingView: View {
    // @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    Section(header: Text("サウンド")) {
                        Toggle(isOn: $timeManager.isAlarmOn){
                            Text("アラーム音")
                        }
                        Toggle(isOn: $timeManager.isVibrationOn){
                            Text("バイブレーション")
                        }
                        Toggle(isOn: $timeManager.isMainCountDown){
                            Text("カウントダウン")
                        }
                        
                        
                        NavigationLink(destination: SoundListView()) {
                            HStack {
                                Text("音の設定")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("\(soundManager.soundName)")
                            }
                        }
                       /* NavigationLink(destination: BgmListView()) {
                            HStack {
                                Text("音の設定")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("\(soundManager.countName)")
                            }
                        } */
                    }
                    Section(header: Text("その他")){
                        Toggle(isOn:$timeManager.isProgressBarOn){
                            Text("プログレスバー")
                        }
                        Toggle(isOn: $timeManager.isintarvalOn) {
                            Text("インターバル")
                        }
                       
                        
                    }
                 
                   
                }
                .disabled(self.timeManager.timerStatus == .running || self.timeManager.intervalTimerStatus == .intervalrunning || self.timeManager.timerStatus == .pause || self.timeManager.intervalTimerStatus == .intervalpause || timeManager.timerStatus == .startcount) 
                .navigationBarTitle("設定",displayMode:.inline)
                .navigationViewStyle(DefaultNavigationViewStyle())
            }
            if timeManager.timerStatus == .running || timeManager.intervalTimerStatus == .intervalrunning  || self.timeManager.timerStatus == .pause || self.timeManager.intervalTimerStatus == .intervalpause || timeManager.timerStatus == .startcount{
           CautionView()
            }
            
        }
       
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
    }
}
