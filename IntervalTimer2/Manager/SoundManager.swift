//
//  SoundManager.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/03/06.
//

import AVFoundation
import AudioToolbox
import Combine
import SwiftUI

// MARK: - SoundManager
final class SoundManager: ObservableObject {
    @EnvironmentObject var timeManager: TimeManager
    @Published var soundID: SystemSoundID = 1151
    @Published var soundName: String = "Beat"
    @Published var countdown = NSDataAsset(name:"Countdown1")!.data
    @Published var countName: String = "countdown1"
    @Published var countBGMPlayer: AVAudioPlayer!
    
// MARK: Methods
    func bgmplay() {
        do {
            countBGMPlayer = try AVAudioPlayer(data: countdown)
            countBGMPlayer.play()
            
        } catch {
            print("BGMエラー")
        }
    }

}
