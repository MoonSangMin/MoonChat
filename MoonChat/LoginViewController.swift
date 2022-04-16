import UIKit
import Firebase
import TextFieldEffects

class LoginViewController: UIViewController {
    @IBOutlet var email: HoshiTextField!
    @IBOutlet var password: HoshiTextField!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    let remoteconfig = RemoteConfig.remoteConfig()
    var color: String!
    
    override func viewDidLoad() {
        color = remoteconfig["splash_background"].stringValue
        
        signInButton.backgroundColor = UIColor(rgb: Int(color!) ?? 123).withAlphaComponent(1.0)
        signUpButton.backgroundColor = UIColor(rgb: Int(color!) ?? 123).withAlphaComponent(1.0)
        
        signUpButton.addTarget(self, action: #selector(presentSignup), for: .touchUpInside)
    }
    
    
    @objc func presentSignup() {
        let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.present(signupVC, animated: true, completion: nil)
    }
    
}
