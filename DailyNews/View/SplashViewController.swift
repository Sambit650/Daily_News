//
//  SplashViewController.swift
//  DailyNews
//
//  Created by Jovial on 9/11/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
  
  @IBOutlet weak var animationBGView: UIView!
  var animationView = AnimationView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    startAnimation()
  }
  
  func startAnimation(){
    animationView.animation = Animation.named("global-mobile-news")
    animationView.frame = animationBGView.bounds
    animationView.contentMode = .scaleAspectFill
    animationView.loopMode = .loop
    animationView.play()
    animationBGView.addSubview(animationView)
    
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
      self.animationView.stop()
      let userCheckIn = UserDefaults.standard.bool(forKey: "isNewUser")
      if userCheckIn == true{
        self.newsScreen()
      }else{
        self.loginScreen()
      }
    }
  }
  
  func newsScreen(){
    //navigate to news Screen
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let tabVC = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController")
    tabVC.modalPresentationStyle = .fullScreen
    present(tabVC, animated: true, completion: nil)
  }
  
  func loginScreen(){
    //navigate to signin Screen
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let signInVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
    signInVC.modalPresentationStyle = .fullScreen
    present(signInVC, animated: true, completion: nil)
  }
  
}
