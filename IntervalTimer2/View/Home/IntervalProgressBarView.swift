//
//  IntervalProgressBarView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/01/14.
//

import SwiftUI

struct IntervalProgressBarView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    var animation: Animation {
        Animation.spring(dampingFraction: 1.5)
    }
    // @State var costomHueA = 0.5
    @State var costomHueB = 0.3
    var body: some View {
        ZStack{
            Circle()
                .stroke(Color(.darkGray),style:StrokeStyle(lineWidth:20))
                .scaledToFit()
                .padding(15)
                .scaleEffect(timeManager.intervalTimerStatus == .intervalrunning ? 1.2 : 1)
                .scaleEffect(timeManager.timerStatus == .running ? 0.8 : 1 )
                .animation(animation)
            Circle()
                .trim(from: 0, to: CGFloat(self.timeManager.intervalDuration / self.timeManager.intervalMaxValue))
            
                .stroke(self.timeManager.countSelection == 0 ? Color.mint : Color.green,style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .bevel))
                .scaledToFit()
                .scaleEffect(timeManager.intervalTimerStatus == .intervalrunning ? 1.2 : 1)
                .scaleEffect(timeManager.timerStatus == .running ? 0.8 : 1 )
                .rotationEffect(Angle(degrees: -90))
                .padding(15)
                .animation(animation)
        }
       
    }
}

struct IntervalProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalProgressBarView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
    }
}
