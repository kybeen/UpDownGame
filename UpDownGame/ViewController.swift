//
//  ViewController.swift
//  UpDownGame
//
//  Created by 김영빈 on 2023/02/04.
//
/*
[ 이벤트 기반 프로그래밍 (Event Driven Programming) ]
 : 어떤 이벤트가 발생했을 때 수행될 코드를 작성
*/

import UIKit

class ViewController: UIViewController {
    
    var randomValue: Int = 0
    var tryCount: Int = 0
    
    // @IBOutlet : 인터페이스 빌더(스토리보드)의 요소와 연결해주는 어노테이션
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tryCountLabel: UILabel!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
    @IBOutlet weak var maximumValueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Image Literal 추가는 { cmd + shift + L }
        slider.setThumbImage(#imageLiteral(resourceName: "slider_thumb.png"), for: .normal)
        reset()
    }

    // @IBAction : 앱 상에서의 동작(이벤트)에 반응하는 액션에 대한 어노테이션
    @IBAction func sliderValueChanged(_ sender: UISlider) { // 슬라이더 이동 시
        print(sender.value)
        // 슬라이더 현재 값 표시
        let integerValue: Int = Int(sender.value)
        sliderValueLabel.text = String(integerValue)
    }
    
    func showAlert(message: String) {
        // alert 창
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        // OK 버튼
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { (action) in
                                        self.reset()
        }
        // alert 창에 OK버튼 추가
        alert.addAction(okAction)
        // alert 창 표시
        present(alert,
                animated: true,
                completion: nil)
    }

    @IBAction func touchUpHitButton(_ sender: UIButton) { // 정답 버튼 눌렀을 때
        print(slider.value)
        // 슬라이더 위치 정수값 기준으로 조정해주기
        let hitValue: Int = Int(slider.value) // 소수점 날려주기
        slider.value = Float(hitValue) // 슬라이더 값은 기본적으로 Float형이기 때문에 다시 Float으로 전환해주어야 함
        
        // 사용자가 시도한 횟수 변경
        tryCount += 1
        tryCountLabel.text = "\(tryCount) / 5"
        
        if randomValue == hitValue { // 정답일 경우
            //print("YOU HIT!!!")
            showAlert(message: "YOU HIT!!!")
            reset()
        } else if tryCount >= 5 { // 횟수 초과 시
            //print("You lose...")
            showAlert(message: "You lose...")
            reset()
        } else if randomValue > hitValue { // 최대/최소값 범위 갱신
            slider.minimumValue = Float(hitValue)
            minimumValueLabel.text = String(hitValue)
        } else {
            slider.maximumValue = Float(hitValue)
            maximumValueLabel.text = String(hitValue)
        }
        
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton) { // 리셋 버튼 눌렀을 때
        print("touch up reset button.")
        reset()
    }
    
    func reset() {
        print("reset!")
        randomValue = Int.random(in: 0...30) // 0부터 30까지 중 임의의 정수
        print(randomValue)
        tryCount = 0
        tryCountLabel.text = "0 / 5"
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = 15
        minimumValueLabel.text = "0"
        maximumValueLabel.text = "30"
        sliderValueLabel.text = "15"
    }
}

