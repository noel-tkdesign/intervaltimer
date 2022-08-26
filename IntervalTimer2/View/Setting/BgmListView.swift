//
//  BgmListView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/02/15.
//

import SwiftUI

struct BgmListView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    let bgms:[Bgm] = [
        Bgm(id: NSDataAsset(name:"Countdown1")!, name: "countdown1"),
        Bgm(id: NSDataAsset(name:"Countdown2")!, name: "countdown2")
    ]
    var body: some View {
        NavigationView {
            List{
                ForEach(bgms) {bgm in
                    HStack{
                        Image(systemName: "speaker.2.fill")
                            .onTapGesture {
                                soundManager.bgmplay()
                            }
                        Text("\(bgm.name)")
                        Spacer()
                        if self.soundManager.countdown == bgm.id.data {
                            Image(systemName: "checkmark")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.soundManager.countdown = bgm.id.data
                        self.soundManager.soundName = bgm.name
                    }
                }
            }
            .navigationBarTitle("音の設定",displayMode: .automatic)
        }
        
    }
}

struct BgmListView_Previews: PreviewProvider {
    static var previews: some View {
        BgmListView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
    }
}
