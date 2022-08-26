//
//  MainTimerView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/01/16.
//

import SwiftUI

struct MainTimerHumanView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    var animation: Animation {
        Animation.spring(dampingFraction: 1.5)
    }
    var body: some View {
        VStack{
            Image("Running Human")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .opacity(self.timeManager.timerStatus == .running ? 0.5 : 0)
                .background(Color.clear)
                .scaleEffect(timeManager.timerStatus == .running ? 1.5 : 1)
                .scaleEffect(timeManager.intervalTimerStatus == .intervalrunning ? 0.8 : 1 )
                .animation(animation)
            if timeManager.isintarvalOn{
                Text("メインタイマー")
                    .font(.caption)
                    .scaleEffect(timeManager.timerStatus == .running ? 1.5 : 1)
                    .scaleEffect(timeManager.intervalTimerStatus == .intervalrunning ? 0.8 : 1 )
                    .opacity(timeManager.timerStatus == .running ? 3.0 : 0.5 )
                    .foregroundColor(Color.black)
            } else {
                Text("タイマー")
                    .font(.caption)
                    .opacity(0.8)
                    .foregroundColor(Color.black)
            }
        }
    }
}

struct MainTimerHumanView_Previews: PreviewProvider {
    static var previews: some View {
        MainTimerHumanView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
        
    }
}
