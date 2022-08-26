//
//  StartCountView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/04/14.
//

import SwiftUI

struct CountDownView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    @State var gocounts = ["Ready","2","1","Go!!","0"]
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    

    var body: some View {
        VStack{
            Text(gocounts[count])
                .font(
                    Font.system(
                        size: 100,
                        weight:.bold,
                        design:.rounded)
                )
                .lineLimit(1)
                .foregroundColor(.pink)
                .scaleEffect(self.count == 0  ? 1.2 : 1)
                .scaleEffect(self.count == 4  ? 1.2 : 1)
                .padding()
            
                .onReceive(timer) { _ in
                           count += 1
                    if count == 1 && timeManager.isAlarmOn {
                        soundManager.bgmplay()
                    }
                    if count >  3 {
                               timer.upstream.connect().cancel()
                        if timeManager.timerStatus != .set{
                               timeManager.start()
                        }
                           }
                       }
            
               }
        }
}

struct StartCountView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
    }
}

