//
//  CountPickerView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2022/02/21.
//

import SwiftUI
import simd

struct CountPickerView: View {
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
   
    var body: some View {
        VStack{
            Text("セット数")
                .font(.caption)
                .foregroundColor(Color.black)
            HStack{
                Picker(selection:self.$timeManager.countSelection ,label: Text("count")){
                    ForEach(0 ..< self.timeManager.countPicker.count){
                        index in
                        Text("\(self.timeManager.countPicker[index])")
                            .tag(index)
                        
                    }
                }
                .frame(width: 20, height: 20)
                .clipped()
                Text("回")
                    .font(.headline)
                    .foregroundColor(Color.black)
            }
        }
    }
}

struct CountPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CountPickerView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
    }
}
