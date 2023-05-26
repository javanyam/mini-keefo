//
//  UserInfoModel.swift
//  semi-keefo
//
//  Created by SNAPTAG on 2023/05/25.
//

import Foundation

struct getUserInfoModel:Codable{
    let statusCode:Int
    let message: String
    let data: UserModel
        
    struct UserModel:Codable{
        let id: Int?
        let created: String?
        let modified: String?
        let deviced: String?
        let profileImageUrl: String?
        let restorationCode: String?
        let countryCode: String?
        let phone: String?
        let name:String?
        let email: String?
        let password: Int?
        let refreshToken:String?
    }
}
