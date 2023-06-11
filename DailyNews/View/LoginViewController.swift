//
//  LoginViewController.swift
//  DailyNews
//
//  Created by Jovial on 9/2/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController, GIDSignInDelegate {

  @IBOutlet weak var childBGView: UIView!
  @IBOutlet weak var parentBGView: UIView!
  @IBOutlet weak var globleImage: UIImageView!
  @IBOutlet weak var signinView: GIDSignInButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    setUI()
  }

  func setUI(){
    GIDSignIn.sharedInstance().delegate = self
    GIDSignIn.sharedInstance()?.presentingViewController = self
    parentBGView.layer.cornerRadius = parentBGView.bounds.height / 2
    childBGView.layer.cornerRadius = childBGView.bounds.height / 2
  }

  override func viewWillAppear(_ animated: Bool) {
    setGradientBackground()
    super.viewWillAppear(animated)
  }

  override func viewDidLayoutSubviews() {
    setGradientBackground()
  }

  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

    //error handaling
    if let error = error {
      if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
        print("The user has not signed in before or they have since signed out.")
      } else {
        print("\(error.localizedDescription)")
      }
      // [START_EXCLUDE silent]
      NotificationCenter.default.post(
        name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
      // [END_EXCLUDE]
      return
    }

    let name = user.profile.name
    let profileURL = user.profile.imageURL(withDimension: .min)

    //Storing userdata in userdefault
    UserDefaults.standard.set(name, forKey: "userName")
    UserDefaults.standard.set(profileURL, forKey: "userProfileURL")
    UserDefaults.standard.set(true, forKey: "isNewUser")

    //navigate to TabBarController
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let VC = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
    VC.modalPresentationStyle = .fullScreen
    present(VC, animated: true, completion: nil)

  }

  //for gradient Color
  func setGradientBackground() {
    let colorTop =  UIColor(red: 28.0/255.0, green: 146.0/255.0, blue: 210.0/255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 241.0/255.0, green: 252.0/255.0, blue: 200.0/255.0, alpha: 1.0).cgColor

    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [colorTop, colorBottom]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.frame = self.view.bounds

    self.view.layer.insertSublayer(gradientLayer, at:0)

  }


}
