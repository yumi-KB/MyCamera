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
        // カメラかフォトライブラリーかの選択肢を提示
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // カメラを起動するための選択肢を定義
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: {
                (action: UIAlertAction) in
                // カメラを起動
                // UIImagePickerContorolleのインスタンスを作成
                let imagePickerController: UIImagePickerController = UIImagePickerController()
                // sourceTypeにcameraを指定
                imagePickerController.sourceType = .camera
                
                // delegate設置
                imagePickerController.delegate = self
                
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
         
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // フォトライブラリーを起動するための選択肢を定義
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: {
                (action: UIAlertAction) in
                // フォトライブラリーを起動
                // UIImagePickerContorolleのインスタンスを作成
                let imagePickerController: UIImagePickerController = UIImagePickerController()
                // sourceTypeにcameraを指定
                imagePickerController.sourceType = .photoLibrary
                
                // delegate設置
                imagePickerController.delegate = self
                
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
            
        // キャンセルの選択肢を定義
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // ipad向け ポップオーバーのための位置情報を指定
        alertController.popoverPresentationController?.sourceView = view
        
        // 選択肢を画面に表示
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func SNSButtonAction(_ sender: Any) {
        // 表示画像をアンラップしてシェア画像として取り出し
        if let shareImage = pictureImage.image {
            
            // UIActivityViewControllerに渡す配列を作成
            let shareItems = [shareImage]
            
            // UIActivityViewControllerにシェア画像を渡す
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            
            // ipad向け ポップオーバーのための位置情報を指定
            controller.popoverPresentationController?.sourceView = view
            
            // UIActivityViewControllerを表示
            present(controller, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // 撮影した写真を、配置したpictureImageに渡す
        pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        // モーダルビューを閉じる
        dismiss(animated: true, completion: nil)
    }
}

