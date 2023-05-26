//
//  HomeViewModel.swift
//  semi-keefo
//
//  Created by SNAPTAG on 2023/05/23.
//

import UIKit

class HomeViewModel{
    var events: Array<getEventsInfoModel.EventsModel>?
}

extension HomeViewModel{
    func getEvent() async {
        let result = await connectURL(parameter: 1)
    }
    
    private func connectURL(parameter: Int){
        let url:URL = getURL(path: .getPath, parameter: parameter).url
        
        DispatchQueue.global().sync {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.sync {
                self.parseJSON(data!)
            }
        }
        
    }
    
    private func parseJSON(_ data:Data){
        let decoder: Decodable
        
        do {
            let result = try JSONDecoder().decode(getEventsInfoModel.self, from: data)
            print(result.statusCode)
            print(result.message)
            print(result.data)
            
//            if let eventsModel = result.data{
//                self.events = []
//
//                var event: Array<String> = []
//                event.forEach(
//
//                )
//            }

        }catch{
            
        }
    }
}
