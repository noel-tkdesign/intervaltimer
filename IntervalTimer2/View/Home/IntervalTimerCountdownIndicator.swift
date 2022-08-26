//
//  IntervalTimerCountdownIndicator.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/01/14.
//

import SwiftUI

struct IntervalTimerCountdownIndicator: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main .bounds.height

    private var fontSize: CGFloat {
        switch timeManager.intervalDisplayedTimeFormat {
        case .intervalhr:
            return screenWidth * 0.15
        case .intervalmin:
            return screenWidth * 0.2
        case .intervalsec:
            return screenWidth * 0.3
        }
    }

    private var textColor: Color {
        timeManager.intervalDuration >= 4 ? Color.black : Color.red
    }

    var body: some View {
        Text(timeManager.IntervalDisplayTimer())
            .font(.system(size: fontSize, weight: .semibold, design: .rounded))
            .lineLimit(1)
            .foregroundColor(textColor)
            .scaleEffect(timeManager.intervalDuration >= 4 ? 1 : 1.2)
            .padding()
    }
}

struct IntervalTimerCountdownIndicator_Previews: PreviewProvider {
    static var previews: some View {
        IntervalTimerCountdownIndicator()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
    }
}
