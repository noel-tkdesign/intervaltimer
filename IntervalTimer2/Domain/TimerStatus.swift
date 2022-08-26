//
//  TimerStatus.swift
//  IntervalTimer2
//
//  Created by 有馬大智 on 2022/03/03.
//

import Foundation

enum TimerStatus {
    case set
    case running
    case pause
    case stopped
    case startcount
    
}

/*extension TimerStatus {
    func description() -> String {
        switch self {
        case .running:
            return "実行中です"
        case .pause:
            return "一時停止中です"
        case .stopped:
            return "スタートしてください"
       
        }
    }
}*/
