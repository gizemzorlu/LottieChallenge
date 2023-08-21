//
//  ViewController.swift
//  LottieChallange
//
//  Created by Gizem Zorlu on 15.08.2023.
//

import UIKit
import Lottie
import SnapKit
import CoreImage

class ViewController: UIViewController {
    
    var loadingAnimationView = LottieAnimationView()
    let button = UIButton()
    let imageView = UIImageView()
    let label = UILabel()
    
    var blurEffectView : UIVisualEffectView!
    let pauseButton = UIButton()
    var isPaused = true
    
    var timer = Timer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemMint
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 10
        imageView.addSubview(blurEffectView)
        
        
        imageView.image = UIImage(named: "thekiss")
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(300)
        }
        
        
        label.text = "Tap the 'Start' button to reveal the artwork. Upon tapping the button, an animation will play. When the animation reaches 100%, the blur effect on the image view will be removed."
        label.backgroundColor = .systemYellow
        label.textAlignment = .center
        label.textColor = .red
        label.numberOfLines = 4
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.top).offset(620)
            make.centerX.equalToSuperview()
            make.width.equalTo(360)
            make.height.equalTo(100)
        }
        
        
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 5
        button.titleLabel?.numberOfLines = 0
        button.addTarget(self, action: #selector(pauseButtonClicked), for: .touchUpInside)
        button.addTarget(self, action: #selector(clearBlur), for: .touchUpInside)
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.top).offset(680)
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
        }
        
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.backgroundColor = .systemPink
        pauseButton.layer.cornerRadius = 5
        pauseButton.titleLabel?.numberOfLines = 0
        pauseButton.addTarget(self, action: #selector(stopButton), for: .touchUpInside)
        view.addSubview(pauseButton)
        
        pauseButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.top).offset(730)
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
        }
        
        loadingAnimationView = .init(name: "loading")
        view.addSubview(loadingAnimationView)
        loadingAnimationView.frame = view.bounds
        loadingAnimationView.isHidden = true

        loadingAnimationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.width.equalTo(100)
        }
        loadingAnimationView.loopMode = .playOnce
        loadingAnimationView.contentMode = .scaleAspectFit
        loadingAnimationView.animationSpeed = 0.5
        
        
    }
    
    @objc func pauseButtonClicked() {
        
        loadingAnimationView.isHidden = false
        isPaused = false
        loadingAnimationView.play()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(clearBlur), userInfo: nil, repeats: true)
        
    }
    
    @objc func clearBlur() {
        
        if Int(loadingAnimationView.currentProgress) == 1 {
            if let removable = imageView.viewWithTag(10) {
                removable.removeFromSuperview()
            }
        }
    }
    
    @objc func stopButton() {
        
        timer.invalidate()
        isPaused = true
        loadingAnimationView.pause()
        
    }
    
    
    
}
        
    
