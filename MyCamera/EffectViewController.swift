//
//  EffectViewController.swift
//  MyCamera
//
//  Created by yumi kanebayashi on 2020/11/07.
//

import UIKit

class EffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 画面遷移時に元の画像を表示
        effectImage.image = originalImage
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var effectImage: UIImageView!
    
    // フィルタ名を列挙した配列
    let filterArray = ["CIPhotoEffectMono",
    "CIPhotoEffectChrome",
    "CIPhotoEffectFade",
    "CIPhotoEffectInstant",
    "CIPhotoEffectNoir",
    "CIPhotoEffectProcess",
    "CIPhotoEffectTonal",
    "CIPhotoEffectTransfer",
    "CISepiaTone"]
    
    // 選択中のエフェクト添え字
    
    var filterSelectNumber = 0
    // 遷移前の画面から画像を設定
    var originalImage: UIImage?
    
    @IBAction func effectButtonAction(_ sender: Any) {
        // エフェクト前画像をアンラップしてエフェクト用画像として取り出す
        if let image = originalImage {
            // フィルター名を指定
            let filterName = filterArray[filterSelectNumber]
            
            // 次の選択するエフェクト添え字に更新
            filterSelectNumber += 1
            
            // 配列の末尾までカウントされたら先頭に戻す
            if filterSelectNumber == filterArray.count {
                filterSelectNumber = 0
            }
            
            // 元々の画像の回転角度を取得
            let rotate = image.imageOrientation
            
            // UIImage形式の画像をCIImage形式の画像に変換
            let inputImage = CIImage(image: image)
            
            // フィルターの種類を引数で指定してCIFilterのインスタンスを取得
            guard let effectFilter = CIFilter(name: filterName) else {
                return
            }
            
            // エフェクトのパラメータを初期化
            effectFilter.setDefaults()
            
            // インスタンスにエフェクトする元画像を設定
            effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
            
            // エフェクト後のCIImage形式の画像を取り出す
            guard let outputImage = effectFilter.outputImage else {
                return
            }
            
            // CIContextのインスタンスを取得
            let ciContext = CIContext(options: nil)
            
            // エフェクト後の画像をCIContext上に描画し、結果をcgImageとしてCGImage形式の画像を取得
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
            
            // エフェクト後の画像をCGImage形式からUIImage形式に変更。その際に回転角度を推定。そして、ImageViewに表示
            effectImage.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        // 表示画像をアンラップしてシェア画像として取り出す
        if let shareImage = effectImage.image {
            // UIActivityViewControllerに渡す配列を作成
            let shareItems = [shareImage]
            
            // UIActivityViewControllerにシェア画像を渡す
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            
            // iPadで落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            
            // UIActivityViewControllerを表示
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
