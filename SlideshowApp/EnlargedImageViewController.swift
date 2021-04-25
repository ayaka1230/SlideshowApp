//
//  EnlargedImageViewController.swift
//  SlideshowApp
//
//  Created by 長坂絢加 on 2021/04/25.
//

import UIKit

class EnlargedImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!
    
    // 遷移元から処理を受け取るクロージャのプロパティを用意
    var updateImageHandler: ((UIImage) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = image
    }
    
    // 戻るボタンをタップしたときに呼ばれるメソッド
    @IBAction func backView(_ sender: Any) {
        // nilチェック
        guard let image = imageView.image else { return }

        if let handler = self.updateImageHandler {
            // 現在表示されている画像を引数として渡された処理の実行
            handler(image)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
