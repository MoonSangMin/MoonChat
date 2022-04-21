import UIKit
import Firebase
import TextFieldEffects

class SignupViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var email: HoshiTextField!
    @IBOutlet var ID: HoshiTextField!
    @IBOutlet var password: HoshiTextField!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    var ref: DatabaseReference!
    
    let remoteconfig = RemoteConfig.remoteConfig()
    var color: String!
    
    @IBAction func addProfileImage(_ sender: Any) {
        imagePicker()
    }
    
    override func viewDidLoad() {
        color = remoteconfig["splash_background"].stringValue
        signupButton.backgroundColor = UIColor(rgb: Int(color!) ?? 123).withAlphaComponent(1.0)
        cancelButton.backgroundColor = UIColor(rgb: Int(color!) ?? 123).withAlphaComponent(1.0)
        
        signupButton.addTarget(self, action: #selector(signupEvent), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelEvent), for: .touchUpInside)
    }
    
    func imagePicker(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func signupEvent(){
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, err) in
            //err code별로 예외처리 필요
            self.ref = Database.database().reference()
            let uid = user?.user.uid
            self.ref.child("users/\(uid!)/userID").setValue(self.ID.text!)
        }
    }
    
    @objc func cancelEvent(){
        self.dismiss(animated: true, completion: nil)
    }
}
