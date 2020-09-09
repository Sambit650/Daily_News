//
//  SideMenuViewController.swift
//  DailyNews
//
//  Created by Jovial on 9/2/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import UIKit
import SideMenu
import GoogleSignIn

class SideMenuViewController: UIViewController {

    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI(){
        userProfile.layer.cornerRadius = userProfile.bounds.height / 2
        
        userName.text = "Name : \(UserDefaults.standard.string(forKey: "userName")!)"
        let defaultImageURL = URL(string : "https://firebasestorage.googleapis.com/v0/b/g-library-91171.appspot.com/o/noProfile.png?alt=media&token=5fba10d7-3d98-4878-b90a-1c50774e0e2e")
        //for userProfile
        let data = try? Data(contentsOf: UserDefaults.standard.url(forKey: "userProfileURL") ?? defaultImageURL!)
        if let imageData = data{
            userProfile.image = UIImage(data: imageData)
        }
    }
    @IBAction func logoutButtonPressed(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        
        //remove userdefault
        UserDefaults.standard.removeObject(forKey: "userProfileURL")
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "isNewUser")
        
        //navigate to Signin Screen
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        VC.modalPresentationStyle = .fullScreen
        present(VC, animated: true, completion: nil)
    }
    
}
