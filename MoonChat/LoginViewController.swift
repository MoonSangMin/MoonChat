import UIKit
import Firebase
import TextFieldEffects

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var email: HoshiTextField!
    @IBOutlet var password: HoshiTextField!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    let remoteconfig = RemoteConfig.remoteConfig()
    var color: String!
    
    override func viewDidLoad() {
        email.delegate = self
        password.delegate = self
        
        try! Auth.auth().signOut()
        color = remoteconfig["splash_background"].stringValue
        
        signInButton.backgroundColor = UIColor(rgb: Int(color!) ?? 123).withAlphaComponent(1.0)
        signUpButton.backgroundColor = UIColor(rgb: Int(color!) ?? 123).withAlphaComponent(1.0)
        
        signUpButton.addTarget(self, action: #selector(presentSignup), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(loginEvent), for: .touchUpInside)
        
        
        Auth.auth().addStateDidChangeListener{ (auth, user) in
            if user != nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case email:
            password.becomeFirstResponder()
        case password:
            password.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    @objc func presentSignup() {
        let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.present(signupVC, animated: true, completion: nil)
    }
    
    @objc func loginEvent(){
        Auth.auth().signIn(withEmail: email.text!, password: password.text!, completion: { (user, err) in
            if let err = err {
                print("login error : \(err)")
            }
            
        })
    }
    
}
