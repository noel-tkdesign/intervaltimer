//
//  ButtonsView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2021/12/31.
//

import SwiftUI

struct ButtonsView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager

    var body: some View {
        HStack {
            Button {
                guard timeManager.timerStatus != .stopped else { return }
                stopTimer()
                print("ストップ")
                if timeManager.isCountDownOn == false {
                    timeManager.isCountDownOn = true
                }
                // 3/9 追加
                guard timeManager.intervalTimerStatus != .intervalstopped else {
                    return
                }
                stopTimer()
                    print("インターバル")
                
            } label: {
                Image(systemName: "stop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .foregroundColor(.red)
                    .opacity(self.timeManager.timerStatus == .stopped && self.timeManager .intervalTimerStatus == .intervalstopped ? 0.1: 1)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
            }
            .frame(maxWidth: .infinity)

            if timeManager.isintarvalOn {
                switch timeManager.timerStatus  {
                case .running, .pause, .set, .startcount:
                    CountView()
                case .stopped:
                    CountPickerView()
              
                }
               
            }

            Button {
                if timeManager.timerStatus == .stopped {
                    self.timeManager.setTimer()
                    if timeManager.isintarvalOn {
                    self.timeManager.IntervalsetTimer()
                    }
                    print("セット")
                }
                
                if  timeManager.timerStatus != .running  {
                    self.timeManager.start()
                    if timeManager.isMainCountDown {
                    if  timeManager.isCountDownOn  {
                        timeManager.StartCount()
                    }
                    }
                    print("スタート")
                } else if timeManager.timerStatus == .running {
                    self.timeManager.pause()
                    self.timeManager.isCountDownOn = false
                    print("一時停止")
                } 
                
            } label:{
                if   timeManager.intervalTimerStatus != .intervalpause && timeManager.timerStatus != .set {
                Image(systemName: self.timeManager.timerStatus == .running  ||  self.timeManager.intervalTimerStatus == .intervalrunning ? "pause.circle.fill" : "play.circle.fill")
                
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 75, height: 75)
                
                    .opacity(self.timeManager.hourSelection == 0 && self.timeManager.minSelection == 0 && self.timeManager.secSelection == 0 || self.timeManager.intervalHourSelection == 0 && self.timeManager.intervalminSelection == 0 && self.timeManager.intervalsecSelection == 0 && self.timeManager.isintarvalOn ? 0.1 : 1)
                    
                    .foregroundColor(self.timeManager.timerStatus == .running || self.timeManager.intervalTimerStatus == .intervalrunning  ? Color.blue : Color.green)
                
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
                }
                if  timeManager.timerStatus == .set {
                BackButtonView()
                }
               /* if  self.timeManager.hourSelection != 0 || self.timeManager.minSelection != 0 || self.timeManager.secSelection != 0 || self.timeManager.intervalHourSelection != 0 || self.timeManager.intervalminSelection != 0 || self.timeManager.intervalsecSelection != 0 && self.timeManager.isintarvalOn && timeManager.timerStatus != .stopped && timeManager.timerStatus != .running && timeManager.timerStatus != .pause {
                    CountDownButtonView()
                } */
            }
            .frame(maxWidth: .infinity)
            
            .disabled(timeManager.isintarvalOn &&
                    timeManager.intervalsecSelection == 0 &&
                         timeManager.intervalHourSelection == 0 &&
                         timeManager.intervalminSelection == 0 )
            
            .disabled(
                      self.timeManager.hourSelection == 0 && self.timeManager.minSelection == 0 && self.timeManager.secSelection == 0 )
            
        }
    }

    func stopTimer() {
        timeManager.reset()
        timeManager.setIntervalState(.intervalstopped)
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
    }
}
