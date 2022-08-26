//
//  CountIView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/02/21.
//

import SwiftUI

struct CountView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    
    var body: some View {
        
        VStack{
            Text("残りセット")
                .font(.caption)
                .foregroundColor(Color.black)
            HStack{
                Text("\(self.timeManager.countSelection)")
                    .frame(width: 20, height: 20)
                    .font(.headline)
                    .foregroundColor(timeManager.countSelection == 2 || timeManager.countSelection == 1  ? Color.red : Color .black)
                Text("回")
                    .font(.caption)
                    .foregroundColor(Color.black)
            }
        }
    }
}



struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        CountView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
    }
}
