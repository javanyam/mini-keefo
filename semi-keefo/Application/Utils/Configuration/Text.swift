//
//  Text.swift
//  semi-keefo
//
//  Created by SNAPTAG on 2023/05/24.
//

import Foundation

enum Text: String{
    case home_title1 = "키포에서만 가능한"
    case home_title2 = "나만의"
    case home_title3 = "디지털 티켓 만들기"
    case button_text = "바로가기"
    case event_text = "이벤트 소식"
}

func textSetting(_ type: Text) -> String{
    return type.rawValue
}
