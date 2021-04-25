//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 長坂絢加 on 2021/04/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var startAndPauseButton: UIButton!
    
    // スライドショーの画像の配列
    var imageArray: [UIImage] = [
        UIImage(named: "cat_01.jpg")!,
        UIImage(named: "cat_02.jpg")!,
        UIImage(named: "cat_03.jpg")!
    ]
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 最初は1つ目の画像を表示する
        imageView.image = self.imageArray[0]
        // 画像をタップできるようにする
        imageView.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enlarged" {
            let enlargedImageViewController:EnlargedImageViewController = segue.destination as! EnlargedImageViewController
            enlargedImageViewController.image = imageView.image
            // 遷移先のプロパティに処理ごと渡す
            enlargedImageViewController.updateImageHandler = { image in
                // 引数を使って imageView の image を更新する処理
                self.imageView.image = image
            }
        }
    }
    
    // 遷移先から戻ってきたときに呼ばれるメソッド
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }

    // 画像をタップしたときに呼ばれるメソッド
    @IBAction func tapImage(_ sender: Any) {
        // 画像を拡大して表示する View に遷移
        performSegue(withIdentifier: "enlarged", sender: nil)
        // スライドショーが再生されている場合はスライドショーを停止する
        if self.timer != nil {
            self.pauseSlideShow()
        }
        // 画像を初期化する
        imageView.image = self.imageArray[0]
    }
    
    // 進むボタンをタップしたときに呼ばれるメソッド
    @IBAction func forward(_ sender: Any) {
        self.changeImageNext()
    }
    
    // 戻るボタンをタップしたときに呼ばれるメソッド
    @IBAction func back(_ sender: Any) {
        self.changeImagePrev()
    }
    
    // 再生/停止ボタンをタップしたときに呼ばれるメソッド
    @IBAction func startAndPause(_ sender: Any) {
        if self.timer == nil {
            self.startSlideShow()
        } else {
            self.pauseSlideShow()
        }
    }
    
    @objc func updateImage(_ timer: Timer) {
        self.changeImageNext()
    }
    
    // 次の画像に変更するメソッド
    func changeImageNext() {
        let currentIndex = self.imageArray.firstIndex(of: imageView.image!)
        let nextIndex = currentIndex == (imageArray.count - 1) ? 0 : (currentIndex! + 1)
        imageView.image = self.imageArray[nextIndex]
    }
    
    // 前の画像に変更するメソッド
    func changeImagePrev() {
        let currentIndex = self.imageArray.firstIndex(of: imageView.image!)
        let prevIndex = currentIndex == 0 ? (imageArray.count - 1) : (currentIndex! - 1)
        imageView.image = self.imageArray[prevIndex]
    }
    
    // スライドショーを再生するときのメソッド
    func startSlideShow() {
        // ボタンの文字を停止にする
        startAndPauseButton.setTitle("停止", for: .normal)
        // タイマーを開始する
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateImage(_:)), userInfo: nil, repeats: true)
        // タイマー起動中は進むボタンと戻るボタンを無効化
        forwardButton.isEnabled = false
        backButton.isEnabled = false
    }

    // スライドショーを停止するときのメソッド
    func pauseSlideShow() {
        // ボタンの文字を再生にする
        startAndPauseButton.setTitle("再生", for: .normal)
        // タイマーを停止する
        self.timer.invalidate()
        self.timer = nil
        // タイマー停止中は進むボタンと戻るボタンを有効化
        forwardButton.isEnabled = true
        backButton.isEnabled = true
    }

}

