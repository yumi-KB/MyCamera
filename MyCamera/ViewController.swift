//
//  ViewController.swift
//  MyCamera
//
//  Created by yumi kanebayashi on 2020/11/05.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var pictureImage: UIImageView!
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("カメラは利用できます")
            
            // UIImagePickerControllerのインスタンスを作成
            let imagePickerController = UIImagePickerController()
            
            // sourceTypeにcameraを指定
            imagePickerController.sourceType = .camera
            
            // delegate設置
            imagePickerController.delegate = self
            
            // モーダルビューで表示
            present(imagePickerController, animated: true, completion: nil)
        } else {
            print("カメラは利用できません")
        }
    }
    
    @IBAction func SNSButtonAction(_ sender: Any) {
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // 撮影した写真を、配置したpictureImageに渡す
        pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        // モーダルビューを閉じる
        dismiss(animated: true, completion: nil)
    }
}

