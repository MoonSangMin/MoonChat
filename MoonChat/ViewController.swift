import UIKit
import SnapKit
import Firebase

class ViewController: UIViewController {
    var box = UIImageView()
    var image: UIImage = UIImage(named: "loading_icon")!
    var remoteConfig: RemoteConfig!
    
    override func viewDidLoad() {
        
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        remoteConfig.fetch { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            self.remoteConfig.activate { changed, error in
              // ...
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
          self.displayWelcome()
        }
        
        self.view.addSubview(box)
        box.snp.makeConstraints{ (make) in
            make.center.equalTo(self.view)
        }
        
        box.image = image
        self.view.backgroundColor = UIColor(rgb: 0x123456).withAlphaComponent(1.0)
    }

    func displayWelcome() {
        let color = remoteConfig["splash_background"].stringValue
        let caps = remoteConfig["splash_message_caps"].boolValue
        let message = remoteConfig["splash_message"].stringValue
        
        if(caps){
            let alert = UIAlertController(title: "공지사항", message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                exit(0)
            })
            
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else {
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            
            self.present(loginVC, animated: false, completion: nil)
            
        }
        
        self.view.backgroundColor = UIColor(rgb: Int(color!) ?? 0).withAlphaComponent(1.0)
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }

    convenience init(rgb: Int) {
           self.init(
               red: (rgb >> 16) & 0xFF,
               green: (rgb >> 8) & 0xFF,
               blue: rgb & 0xFF
           )
       }

    // let's suppose alpha is the first component (ARGB)
    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }
}
