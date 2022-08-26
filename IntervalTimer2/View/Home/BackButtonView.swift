//
//  BackButtonView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/03/19.
//

import SwiftUI

struct BackButtonView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    var body: some View {
        Button{
           
            if timeManager.intervalTimerStatus == .intervalpause{
                // 3/9 追加
            
                self.timeManager.intervalStart()
                print("インターバルスタート")
            } else if timeManager.intervalTimerStatus  == .intervalrunning {
                self.timeManager.setIntervalState(.intervalpause)
                
            }
        
                
               
            
            
        }label: {
            Image(systemName: self.timeManager.intervalTimerStatus == .intervalrunning ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 75, height: 75)
                .foregroundColor(self.timeManager.timerStatus == .running || self.timeManager.intervalTimerStatus == .intervalrunning  ? Color.blue : Color.green)
            
                .background(Color.white.opacity(0.8))
                .clipShape(Circle())
        }
      
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
    }
}
