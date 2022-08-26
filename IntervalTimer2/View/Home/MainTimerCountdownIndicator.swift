//
//  MainTimerCountdownIndicator.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2021/12/29.
//

import SwiftUI

struct MainTimerCountdownIndicator: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    // UIScreen.main.boundsは場合によってはレイアウトが崩れるので、違う方法を推奨します。（難易度高めですが）
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
   /* var animation: Animation {
        Animation.interactiveSpring(dampingFraction: 1.0)
    }*/

    private var fontSize: CGFloat {
        switch timeManager.displayedTimeFormat {
        case .hr:
            return screenWidth * 0.15
        case .min:
            return screenWidth * 0.2
        case .sec:
            return screenWidth * 0.3
        }
    }

    private var textColor: Color {
        timeManager.duration >= 4 ? Color.black : Color.red
    }

    var body: some View {
        Group {
            Text(timeManager.displayTimer())
                .font(
                    Font.system(
                        size: fontSize,
                        weight:.semibold,
                        design: .rounded)
                )
                .lineLimit(1)
                .foregroundColor(textColor)
                .padding()
                .scaleEffect(timeManager.duration >= 4 ? 1 : 1.2)
                //.animation(animation)
            
        }
    }
}

struct MainTimerCountdownIndicator_Previews: PreviewProvider {
    static var previews: some View {
        MainTimerCountdownIndicator()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
    }
}
