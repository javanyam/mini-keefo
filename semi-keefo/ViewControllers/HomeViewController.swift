//
//  HomeViewController.swift
//  semi-keefo
//
//  Created by SNAPTAG on 2023/05/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTitle1: UILabel!
    @IBOutlet weak var homeTitle2: UILabel!
    @IBOutlet weak var homeTitle3: UILabel!
    @IBOutlet weak var buttonText: UILabel!
    @IBOutlet weak var eventText: UILabel!
    @IBOutlet weak var bannerView: UIImageView!
    
    private var logoImageView:UIImageView!
    private var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        textSetting()
        logoImageSetting()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task{
            await getEventsData()
        }
    }
}

extension HomeViewController{
    
    private func logoImageSetting(){
        let logoImage = customImage(.logo)
        logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = logoImageView
    }
    
    private func textSetting(){
        homeTitle1.text = semi_keefo.textSetting(Text.home_title1)
        homeTitle2.text = semi_keefo.textSetting(Text.home_title2)
        homeTitle3.text = semi_keefo.textSetting(Text.home_title3)
        buttonText.text = semi_keefo.textSetting(Text.button_text)
        eventText.text = semi_keefo.textSetting(Text.event_text)
    }
    
    private func getEventsData() async{
        let result = await viewModel.getEvent()
    }
}

//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//
//
//}
//
//extension HomeViewController:UICollectionViewDelegateFlowLayout{
//
//}
