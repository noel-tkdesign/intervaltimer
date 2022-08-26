//
//  ContentView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2021/12/27.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName:"timer")
                    Text("タイマー")
                }

            SettingView()
                .tabItem {
                    Image(systemName:"gear")
                    Text("設定")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
    }
}
