//
//  SplashViewModel.swift
//  semi-keefo
//
//  Created by SNAPTAG on 2023/05/23.
//

import UIKit
import LabCodeSDK

class SplashViewModel{
    
    func checkSDK(completion: @escaping((Bool)->Void)){
        LabCodeSDK.LoginManager.shared.labcode(
            apiKey: "0483e5fc-19e1-4669-a994-d3c5d9255dff",
            apiSecret: "18a300f8-e201-42f3-accd-a491838d1cad",
            completion: { result in
                if result == .success{
                    completion(true)
                }else{
                    completion(false)
                }
                
            }
        )
    }
    
    func checkUser() async -> Bool{
        let result = await connectURL(parameter: 2)
        
        switch result{
        case 200:
            return true
        default:
            return false
        }
    }

    private func connectURL(parameter: Int) -> Int{
        var result:Int = 0
        let url:URL = getURL(path: .getPath, parameter: parameter).url
        
        DispatchQueue.global().sync {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.sync {
                result = self.parseJSON(data!)
//                print(result)
            }
        }
        
        return result
    }
    
    private func parseJSON(_ data: Data) -> Int{
        do{
            let result = try JSONDecoder().decode(getUserInfoModel.self, from: data)
//            print(result.statusCode)
//            print(result.message)
//            print(result.data)
            return result.statusCode
        }catch{
            return 0
        }
    }
}
