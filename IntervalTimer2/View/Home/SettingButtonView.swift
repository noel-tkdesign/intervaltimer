//
//  SettingButtonView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/01/05.
//

import SwiftUI

struct SettingButtonView: View {
    @EnvironmentObject var timeManeger: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    var body: some View {
        VStack{
            Image(systemName: "ellipsis.circle.fill")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
                .onTapGesture {
                    self.timeManeger.isSetting = true
                    
                }
            Text("設定")
                .foregroundColor(.blue)
        }
    }
}

struct SettingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SettingButtonView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
    }
}
