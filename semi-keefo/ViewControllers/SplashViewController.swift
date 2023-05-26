//
//  SplashViewController.swift
//  semi-keefo
//
//  Created by SNAPTAG on 2023/05/23.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    private var animationView: LottieAnimationView!
    private var viewModel = SplashViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        userCheck()
    }
}

extension SplashViewController{
    
    private func userCheck() {
        viewModel.checkSDK(completion: { result in
            if result{
                Task{
                    let checkUser = await self.viewModel.checkUser()
//                    print(checkUser)
                    if checkUser{
                        self.playLottie()
                    }
                    else{
                        // 유저 미확인 popup
                    }
                }
            }
            else{
                // sdk 미확인 popup
            }
        })
    }
    
    private func playLottie(){
        animationView = .init(name: "heart_rain")
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1
        self.view.addSubview(animationView)
        animationView.play(toFrame:120){_ in
            
            self.navigateTabbar()
        }
    }
    
    private func navigateTabbar(){
        guard let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") else{return}
        self.navigationController?.pushViewController(tabBarVC, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
}
