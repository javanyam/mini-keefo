//  Copyright 2021. 'SnapTag Inc.' all rights reserved.
//  Updated by 이민우 on 2023/04/07

import UIKit

// 1-1. 모듈 사용을 위해 'LabCodeSDK'을 import합니다.
import LabCodeSDK

// 1-2. 정상적으로 모듈을 사용하기 위해서는 'DetectViewController'를 상속받아야 합니다.
class ScanViewController: DetectViewController {

    @IBOutlet weak var torchButton: UIButton!
    @IBOutlet weak var zoomButton: UIButton!

    let zoomOnImage: UIImage! = UIImage(named: "zoom_on_icon")
    let zoomOffImage: UIImage! = UIImage(named: "zoom_off_icon")
    let torchOnImage: UIImage! = UIImage(named: "torch_on_icon")
    let torchoffImage: UIImage! = UIImage(named: "torch_off_icon")

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1-3. 검출된 랩코드를 통해 데이터를 얻기 위해서는 필수적으로 다음과 같이 할당해줘야합니다.
        self.delegate = self
        
        // 1-4. *LabTracking 이용할 수 있습니다.
        /*
         LabTracking을 통해 사용자 디바이스의 *스캔 환경 정보를 수집하고 이를 통해 스캔 실패 원인을 분석합니다.
         uniqueValue는 사용자를 구분할 수 있는 값이며, 해당 값을 통해 보다 쉽게 특정 유저의 LabTracking 정보를 구분할 수 있습니다.
         */
        self.activateLabTracking(uniqueValue: "스냅태그")
        
        self.configure()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
                
    }
    
    @IBAction func tapTorchButton(_ sender: UIButton) {

        let currentTorchStatus: Bool = self.getCurrentTorchStatus()
        self.controlTorch(on: !currentTorchStatus)
        self.setTorchButton(value: !currentTorchStatus)
        
    }
    
    @IBAction func tapZoomButton(_ sender: UIButton) {

        let zoomStatus: Bool = (self.getCurrentZoomLevel() == .HIGH) ? true : false
        let zoomLevel: ZoomLevel = (zoomStatus) ? .NORMAL : .HIGH
        self.controlZoom(level: zoomLevel)
        self.setZoomButton(value: !zoomStatus)
        
        
    }
}

extension ScanViewController {
    
    func configure() {

        // 2-1. 랩코드를 인식했을 때 사운드 및 진동을 실행합니다. (기본값 모두 false)
        self.setSoundStatus(value: true)
        self.setVibrationStatus(value: true)
        
        // 2-2. 랩코드를 인식했을 때 나오는 사운드를 변경할 수 있습니다. 해당 프로젝트에 포함되어있는 'beep.mp3'파일을 그대로 사용하셔도 됩니다. 다른 사운드 파일을 원하신다면 하단처럼 바꾸고자 하는 사운드 파일의 파일명과 파일형식을 입력하시면 됩니다.
        self.changeSound(fileName: "beep", fileType: "mp3")
       
        // 2-3. 해당값을 true로 두면 Zoom, Torch, Sound, Vibration의 값들을 저장합니다. (기본값 == true), 값이 true라면 Foreground, Background 등에서도 Zoom, Torch 기능이 자동으로 적용됩니다.
//        self.dectivateAutoSavingMode()
        
        // 2-4. 해당값을 true로 두면 랩코드를 인식했을 때 사운드 및 진동이 실행되지 않습니다. 'playSound', 'playVibration' 메소드를 직접 활용해 실행할 수 있습니다.
//        self.activateSilentMode()

        // 2-5. 해당 메소드를 통해 Torch, Zoom의 최초 시작값(UserDefaults)을 설정할 수 있습니다. (기본값은 Torch => false, Zoom => normal)
//        self.initFirstProperties(torch: false, zoom: .NORMAL)
        
        // 2-6. 해당 메소드들을 통해 스캔 기능을 멈추거나 다시 시작할 수 있습니다. (ex.팝업 표시할 경우 => Stop, 팝업 닫을 경우 => Start )
//        self.stopSession()
//        self.startSession()
        
        // 2-7. 현재 저징된 Zoom, Torch값을 불러옵니다. (AutoSavingMode가 활성화된 상태에서만 정확한 값을 불러올 수 있습니다.)
        let savedTorchStatus: Bool = self.getCurrentTorchStatus()
        let savedZoomStatus: Bool = (self.getCurrentZoomLevel() == .NORMAL) ? false : true
        
        DispatchQueue.main.async {
            self.setTorchButton(value: savedTorchStatus)
            self.setZoomButton(value: savedZoomStatus)
        }
    }
    
    // 2-8. Foreground로 진입한 경우에 원하는 작업을 추가할 수 있습니다.
    override func applicationDidBecomeActive() {
        super.applicationDidBecomeActive()
    }
//
//    // 2-9. Background로 진입한 경우에 원하는 작업을 추가할 수 있습니다.
    override func applicationDidEnterBackground() {
        super.applicationDidEnterBackground()
    }
    
}

extension ScanViewController {

    func setTorchButton(value: Bool) {
        let torchImage: UIImage = (value) ? self.torchOnImage : self.torchoffImage
        self.torchButton.setImage(torchImage, for: .normal)
    }
    
    func setZoomButton(value: Bool) {
        let zoomImage: UIImage = (value) ? self.zoomOnImage : self.zoomOffImage
        self.zoomButton.setImage(zoomImage, for: .normal)
    }
}

extension ScanViewController: DetectViewControllerProtocol {

    
    // 3-1. SDK를 정상적으로 사용할 수 없는 여러 *예외적인 상황에 대해 알 수 있습니다.
    /*
        1. NoConfiguration
            1-1. checkValidity가 정상적으로 실행되지 않은 경우 (ex.네트워크 연결 실패...)
            1-2. SDK 접근 권한이 없는 계정일 경우
            1-3. 그외
        2. NotSupportedDevice => iPhone이 아닌 기종으로 실행한 경우 (ex. simulator, iPad...)
        3. NoPermission => Camera Permission이 접근 제한된 경우
     */
    func abnormalExecution(reason: String) {
        print("<LabCodeSDKDemo> abnormalExecution : \(reason)")

    }
    
    // 3-2. 인식된 랩코드의 데이터를 확인할 수 있습니다.
    func getDetectResult(data: Dictionary<String, Any>) {
        print("<LabCodeSDKDemo> getDetectResult : \n\(data)")
        
        DispatchQueue.main.async {
            let resultViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            resultViewController.modalTransitionStyle = .crossDissolve
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated: false, completion: nil)
        }
    }
}

