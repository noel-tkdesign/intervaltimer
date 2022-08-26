//
//  IntervalTimerHumanView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/01/16.
//

import SwiftUI

struct IntervalTimerHumanView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    var animation: Animation {
        Animation.spring(dampingFraction: 1.5)
    }
    var body: some View {
        VStack{
            Image("IntervalHuman")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 120, height: 120)
                .scaleEffect(timeManager.timerStatus == .running ? 0.8 : 1)
                .scaleEffect(timeManager.intervalTimerStatus == .intervalrunning ? 1.5 : 1 )
                .opacity(self.timeManager.intervalTimerStatus == .intervalrunning ? 0.5 : 0)
                .animation(animation)
            if timeManager.countSelection == 0 {
                Text("クールダウン")
                    .font(.caption)
                    .scaleEffect(timeManager.timerStatus == .running ? 0.8 : 1)
                    .scaleEffect(timeManager.intervalTimerStatus == .intervalrunning ? 1.5 : 1 )
                    .opacity(timeManager.intervalTimerStatus == .intervalrunning ? 3.0 : 0.5 )
                    .foregroundColor(Color.black)
                    
            }
            if timeManager.countSelection != 0 {
                Text("インターバル")
                .font(.caption)
                .scaleEffect(timeManager.timerStatus == .running ? 0.8 : 1)
                .scaleEffect(timeManager.intervalTimerStatus == .intervalrunning ? 1.5 : 1 )
                .opacity(timeManager.intervalTimerStatus == .intervalrunning ? 3.0 : 0.5 )
                .foregroundColor(Color.black)
            }
        }
    }
}

struct IntervalTimerHumanView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalTimerHumanView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
    }
}
