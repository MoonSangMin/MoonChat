import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    let remoteconfig = RemoteConfig.remoteConfig()
    var color: String!
    
    override func viewDidLoad() {
        color = remoteconfig["splash_background"].stringValue
        
        signInButton.backgroundColor = UIColor(rgb: Int(color!) ?? 123).withAlphaComponent(1.0)
        signUpButton.backgroundColor = UIColor(rgb: Int(color!) ?? 123).withAlphaComponent(1.0)
    }
    
}
