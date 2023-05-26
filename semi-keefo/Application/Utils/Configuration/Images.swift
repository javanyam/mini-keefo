//
//  Images.swift
//  test-keefo
//
//  Created by SNAPTAG on 2023/05/22.
//

import UIKit

enum SystemImageName:String{
    case cancelIcon = "xmark"
}

enum CustomImageName:String{
    case logo = "top_navigation_logo"
    case splash = "splash3"
}

func customImage(_ name: CustomImageName) -> UIImage{
    return UIImage(named: name.rawValue) ?? UIImage(systemName: SystemImageName.cancelIcon.rawValue)!
}
