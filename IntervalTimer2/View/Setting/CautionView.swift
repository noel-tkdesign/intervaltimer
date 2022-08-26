//
//  CautionIView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/03/27.
//

import SwiftUI

struct CautionView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    var body: some View {
        ZStack{
            Color.gray
                .ignoresSafeArea()
                .opacity(0.1)
            
            VStack{
                Spacer()
                    .frame(height:300)
                
            Text("タイマー再生中は設定を変更できません   変更の際は赤い停止ボタンでリセットしてください")
               
                .font(.headline)
                .foregroundColor(.gray)
                Spacer()
                    .frame(height:0)
            }
        }
        
    }
}

struct CautionIView_Previews: PreviewProvider {
    static var previews: some View {
        CautionView()
    }
}
