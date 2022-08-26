//
//  ProgressBarView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/01/08.
//

import SwiftUI

struct ProgressBarView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    @State var costomHueA = 0.5
    @State var costomHueB = 0.3
    var animation: Animation {
        Animation.spring(dampingFraction: 1.5)
    }
    var body: some View {
        ZStack{
            Circle()
                .stroke(Color(.darkGray),style:StrokeStyle(lineWidth:20))
                .scaledToFit()
                .padding(15)
                .scaleEffect(timeManager.timerStatus == .running ? 1.2 : 1)
                .scaleEffect(timeManager.intervalTimerStatus == .intervalrunning ? 0.8 : 1 )
                .animation(animation)
            Circle()
                .trim(from: 0, to: CGFloat(self.timeManager.duration / self.timeManager.maxValue))
                .stroke( Color("Blue"),style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .bevel))
                .scaledToFit()
                .scaleEffect(timeManager.timerStatus == .running ? 1.2 : 1)
                .scaleEffect(timeManager.intervalTimerStatus == .intervalrunning ? 0.8 : 1 )
                .rotationEffect(Angle(degrees: -90))
                .padding(15)
                .animation(animation)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
    }
}
