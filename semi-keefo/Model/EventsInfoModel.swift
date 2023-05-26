//
//  UserCheckModel.swift
//  semi-keefo
//
//  Created by SNAPTAG on 2023/05/25.
//

import Foundation

struct getEventsInfoModel:Codable{
    let statusCode: Int
    let message: String
    let data: [EventsModel]
    
    struct EventsModel:Codable{
        let id: Int
        let created: String
        let status: Bool
        let name: String
        let artist: String
        let regionId : Int
        let bannerImage: String
        let eventType: String
        let link: String
        let isVisible: Bool
        let eventTag: [TagsModel]
        
        struct TagsModel: Codable{
        let id: Int
        let tag: String
        let eventId: Int
        }
    }
}
