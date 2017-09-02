//
//  RegisterViewController.swift
//  Dplug
//
//  Created by Lan Tran on 8/18/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit


class RegisterViewController: BaseViewController {
    @IBOutlet weak var btnSubmit: UIButton!


    @IBOutlet weak var emailText: TextField!
    @IBOutlet weak var usernameText: TextField!
    @IBOutlet weak var passwordText: TextField!
    @IBOutlet weak var confirmpassText: TextField!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var heightView: NSLayoutConstraint!
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var urlAvata: String?
    var isPressSubmit = false
    let imagePicker = UIImagePickerController()
    var fKeyboardShow: Bool = false
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func eventBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eventSubmit(_ sender: Any) {
        if avatarImage.image != nil {
            if let url = urlAvata {
                signUp(avata: url)
            } else {
                isPressSubmit = true
            }
        } else {
            signUp(avata: nil)
        }
    }
  
    @IBAction func eventChooseAvatar(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
   
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let imageNew = pickedImage.resizeImageWith(newSize: CGSize(width: 50, height: 50))
            avatarImage.image = imageNew
            let paths = saveImage(image: imageNew)
            self.urlAvata = nil
            
            APIService.shareInstance.uploadImage(paths: paths, completion: { result in
                if let data = result as? NSDictionary{
                    self.urlAvata = data["url"] as? String
                    if self.isPressSubmit {
                        self.signUp(avata: self.urlAvata)
                    }
                }
            })
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension RegisterViewController {
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if !fKeyboardShow {
                scrollView.isScrollEnabled = true
                heightView.constant = Constant.height - self.btnSubmit.frame.maxY
                heightScrollView.constant -= keyboardSize.height
                fKeyboardShow = true
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if fKeyboardShow {
                scrollView.isScrollEnabled = false
                heightScrollView.constant += keyboardSize.height
                heightView.constant = 0
                fKeyboardShow = false
            }
        }
    }
    
    func saveImageData(data: Data) -> URL? {
        
        let randomFilename = "avata"
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = URL(fileURLWithPath: documentsPath).appendingPathComponent((randomFilename) + ".png")
        do {
            try data.write(to: path)
            return path
        } catch {
            return nil
        }
    }
    
    func saveImage(image: UIImage) -> URL {
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("avata.png")
        let imageData = UIImageJPEGRepresentation(image, 1)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        return URL(fileURLWithPath: paths)
    }
    
    func signUp(avata: String?){
        guard let username = usernameText.text else { return }
        guard let password = passwordText.text else { return }
        let confirmpass = confirmpassText.text
        guard let email = emailText.text else { return }
        let provider = "local"
        
        if !username.isUsername()
            || !password.isPassword()
            || !email.isEmail()
            || !password.isEqual(confirmpass) {
            print("username or password invalid")
            return
        }
        
        
        APIService.shareInstance.signUpEmail(username: username, password: password, email: email, provider: provider, avata: avata,completion: { result in
            print("eventSubmit - success: \(String(describing: result))")
            
        }) { message in
            self.isPressSubmit = false
            print("eventSubmit - error message: \(message)")
        }
    }
}
