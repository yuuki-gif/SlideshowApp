//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 細見勇木 on 2020/08/26.
//  Copyright © 2020 Yuki.Hosomi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 配列に指定するindex番号を宣言
    var nowIndex:Int = 0
    
    // スライドショーに使用するタイマーを宣言
    var timer: Timer!
    
    // スライドショーさせる画像の配列を宣言
    var imageArray:[UIImage] = [
        UIImage(named: "apple0001.jpg")!,
        UIImage(named: "apple0002.jpg")!,
        UIImage(named: "apple0003.png")!,
    ]
    
    // 画像の名前の配列
    let imageNameArray = [
        "apple0001.jpg",
        "apple0002.jpg",
        "apple0003.png",
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のResultViewControllerを取得する
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        //遷移先のイメージビューへ画像を代入する。
        resultViewController.beautifulImage = imageView.image
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    /// 表示している画像の番号
    var dispImageNo = 0
    
    /// 表示している画像の番号を元に画像を表示する
    func displayImage() {
        
        
        // 画像の番号が正常な範囲を指しているかチェック
        
        // 範囲より下を指している場合、最後の画像を表示
        if dispImageNo < 0 {
            dispImageNo = 2
        }
        
        // 範囲より上を指している場合、最初の画像を表示
        if dispImageNo > 2 {
            dispImageNo = 0
        }
        
        // 表示している画像の番号から名前を取り出し
        let name = imageNameArray[dispImageNo]
        print(name)
        print(dispImageNo)
        // 画像を読み込み
        let image = UIImage(named: name)
        
        // Image Viewに読み込んだ画像をセット
        imageView.image = image
        
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func didTapBackButton (sender: AnyObject) {
        
        // 表示している画像の番号を1減らす
        dispImageNo -= 1
        
        // 表示している画像の番号を元に画像を表示する
        displayImage()
    }
    
    
    @IBAction func didTapNext(sender: AnyObject) {
        
        // 表示している画像の番号を1増やす
        dispImageNo += 1
        
        // 表示している画像の番号を元に画像を表示する
        displayImage()
    }
    
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func slideShowButton(_ sender: Any) {
        // 再生中か停止しているかを判定
        if (timer == nil) {
            // 再生時の処理を実装
            
            // タイマーをセットする
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
            
            // ボタンの名前を停止に変える
            startButton.setTitle("停止", for: .normal)
            
            //UIButtonを無効にする。
            backButton.isEnabled = true
            //念の為UIButtonを非表示
            backButton.isHidden = true
            
            //UIButtonを無効にする。
            nextButton.isEnabled = true
            //念の為UIButtonを非表示
            nextButton.isHidden = true
            
            
        } else {
            
            // 停止時の処理を実装
            // タイマーを停止する
            timer.invalidate()
            
            // タイマーを削除しておく(timer.invalidateだけだとtimerがnilにならないため)
            timer = nil
            
            // ボタンの名前を再生に直しておく
            startButton.setTitle("再生", for: .normal)
            
            //UIButtonを有効化
            backButton.isEnabled = true
            //UIButtonを表示
            backButton.isHidden = false
            
            //UIButtonを有効化
            nextButton.isEnabled = true
            //UIButtonを表示
            nextButton.isHidden = false
            
        }
        
    }
    @objc func changeImage() {
        // indexを増やして表示する画像を切り替える
        nowIndex += 1
        
        // indexが表示予定の画像の数と同じ場合
        if (nowIndex == imageArray.count) {
            // indexを一番最初の数字に戻す
            nowIndex = 0
        }
        // indexの画像をstoryboardの画像にセットする
        imageView.image = imageArray[nowIndex]
        
    }
}
