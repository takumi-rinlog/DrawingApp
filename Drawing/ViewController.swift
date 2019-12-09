//
//  ViewController.swift
//  Drawing
//
//  Created by HT-19R1108 on 2019/12/09.
//  Copyright © 2019 HT-19R1108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ivImage: UIImageView!
    
    var pos01: CGPoint!
    var pos02: CGPoint!
    
    // スライダー使用のため初期値nil
    var wd: Float!
    
    // 初期色：黒
    var chColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    // 画面タッチ開始時
    override func touchesBegan(
        _ touches: Set<UITouch>, with event: UIEvent?) {
        
        // タッチ開始座標の保持
        // imgViewを基準に場所の情報を取得
        pos01 = touches.first?.location(in: ivImage)
        
    }
    
    // 画面タッチ　ドラッグ時
    override func touchesMoved(
        _ touches: Set<UITouch>, with event: UIEvent?) {
        
        // タッチ終了座標の保持
        pos02 = touches.first?.location(in: ivImage)
        
        // 描画処理
        drawCanvas()
        
        // タッチ座標の再設定
        pos01 = pos02
        
    }
    
//    // 画面から指を離した時
//    override func touchesEnded(
//        _ touches: Set<UITouch>, with event: UIEvent?) {
//        print(#function)
//    }
    
    
    // 描画処理の内容(オフスクリーンをimgViewに表示させる)
    
    func drawCanvas() {
        
        // ----------------------------------------
        // オフスクリーンの作成
        // ----------------------------------------
        UIGraphicsBeginImageContextWithOptions(
            view.bounds.size, false, 0.0)
        
        ivImage.image?.draw(in: ivImage.frame)
        
        // ----------------------------------------
        // オフスクリーンの作成への描画
        // ----------------------------------------
        
        //グラフィックス・コンテキストの取得
        let gc = UIGraphicsGetCurrentContext()!
        
        // 設定１（線の太さ）
        if wd == nil { wd = 5.0 }
        
        let wdt = CGFloat(wd)
        gc.setLineWidth(wdt)
        
        // 設定２　ペン先の変更
        gc.setLineCap(.round)
        
        // 設定３　色の変更
        gc.setStrokeColor(chColor.cgColor)
        
        // 線の描画
        gc.move(to: pos01) // 線の起点
        gc.addLine(to: pos02) // pos02に向けて線を引っ張る
        gc.strokePath()
        
        
        // ----------------------------------------
        // オフスクリーンの内容反映
        // ----------------------------------------
        
        ivImage.image =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    @IBAction func lineWidth(_ sender: UISlider) {
    
        wd = sender.value
    }
    
    @IBAction func colorChange(_ sender: UISegmentedControl) {
    
        switch sender.selectedSegmentIndex {
        
        case 0:
            chColor = UIColor.black
            
        case 1:
            chColor = UIColor.blue
        
        case 2:
            chColor = UIColor.red
        
        case 3:
            chColor = UIColor.yellow
            
        default:
            break
        }
        
    }
    
    @IBAction func btErase(_ sender: Any) {
        
        chColor = UIColor.white
    }
    
    
    @IBAction func btClear(_ sender: Any) {
        
    }
    
}

