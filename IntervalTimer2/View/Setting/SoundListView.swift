//
//  SoundListView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/01/05.
//

import SwiftUI
import AudioToolbox

struct SoundListView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    
    let sounds: [Sound] = [
        
        Sound(id: 1151, soundName: "Beat"),
        Sound(id: 1304, soundName: "Aleat"),
       // Sound(id: 1309, soundName: "Glass"),
        Sound(id: 1310, soundName: "Horn"),
        Sound(id: 1313, soundName: "Ball"),
        Sound(id: 1314, soundName: "Electronic"),
       // Sound(id: 1320, soundName: "Anticipate"),
        //Sound(id: 1327, soundName: "Minuet"),
        Sound(id: 1328, soundName: "News Flash"),
        Sound(id: 1330, soundName: "Sherwood Forest"),
        Sound(id: 1333, soundName: "Telegraph"),
        Sound(id: 1334, soundName: "Tiptoes"),
        Sound(id: 1335, soundName: "Typewriterst"),
        Sound(id: 1336, soundName: "Update")
    ]
    var body: some View {
        List {
            ForEach(sounds, id: \.id) { sound in
                HStack{
                    Image(systemName: "speaker.2.fill")
                        .onTapGesture {
                            AudioServicesPlayAlertSoundWithCompletion(sound.id, nil)
                        }
                    Text("\(sound.soundName)")
                    Spacer()
                    if self.soundManager.soundID == sound.id {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    self.soundManager.soundID = sound.id
                    self.soundManager.soundName = sound.soundName
                }
            }
        }
        .navigationBarTitle("音の設定",displayMode:.inline)
    }
}

struct SoundListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SoundListView()
                .environmentObject(TimeManager())
                .environmentObject(SoundManager())
        }
    }
}
