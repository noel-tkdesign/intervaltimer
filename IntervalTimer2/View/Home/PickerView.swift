//
//  PickerView.swift
//  IntervalTimer2
//
//  Created by Koji Kawakami on 2021/12/29.
//

import SwiftUI

struct PickerView: View {
    //TimeManagerのインスタンスを作成
    @EnvironmentObject var timeManager: TimeManager
    @EnvironmentObject var soundManager: SoundManager
    //デバイスのスクリーンの幅
    let screenWidth = UIScreen.main.bounds.width
    //デバイスのスクリーンの高さ
    let screenHeight = UIScreen.main.bounds.height
    //設定可能な時間単位の数値
    var hours = [Int](0..<24)
    //設定可能な分単位の数値
    var minutes = [Int](0..<60)
    //設定可能な秒単位の数値
    var seconds = [Int](0..<60)
    
    var body: some View {
        //ZStackでPickerとレイヤーで重なるようにボタンを配置
        ZStack{
            //時間、分、秒のPickerとそれぞれの単位を示すテキストをHStackで横並びに
            HStack {
                //時間単位のPicker
                Picker(selection: self.$timeManager.hourSelection, label: Text("hour")) {
                    ForEach(0 ..< self.hours.count) { index in
                        Text("\(self.hours[index])")
                            .tag(index)
                    }
                }
                //上下に回転するホイールスタイルを指定
                //.pickerStyle(WheelPickerStyle())
                //ピッカーの幅をスクリーンサイズ x 0.1、高さをスクリーンサイズ x 0.4で指定
                .frame(width: self.screenWidth * 0.1, height: self.screenWidth * 0.4)
                //上のframeでクリップし、フレームからはみ出す部分は非表示にする
                .clipped()
                //時間単位を表すテキスト
                Text("時")
                    .font(.headline)
                    .foregroundColor(Color.black)
                
                //分単位のPicker
                Picker(selection: self.$timeManager.minSelection, label: Text("minute")) {
                    ForEach(0 ..< self.minutes.count) { index in
                        Text("\(self.minutes[index])")
                            .tag(index)
                    }
                }
                //.pickerStyle(WheelPickerStyle())
                .frame(width: self.screenWidth * 0.1, height: self.screenWidth * 0.4)
                .clipped()
                //分単位を表すテキスト
                Text("分")
                    .font(.headline)
                    .foregroundColor(Color.black)
                
                //秒単位のPicker
                Picker(selection: self.$timeManager.secSelection, label: Text("second")) {
                    ForEach(0 ..< self.seconds.count) { index in
                        Text("\(self.seconds[index])")
                            .tag(index)
                    }
                }
                //.pickerStyle(WheelPickerStyle())
                .frame(width:self.screenWidth * 0.1, height: self.screenWidth * 0.4)
                .clipped()
                //秒単位を表すテキスト
                Text("秒")
                    .font(.headline)
                    .foregroundColor(Color.black)
            }
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
            .environmentObject(TimeManager())
            .environmentObject(SoundManager())
            .previewLayout(.sizeThatFits)
    }
}
