//
//  ViewController.swift
//  ZLAlertView
//
//  Created by Yuki on 2020/8/10.
//  Copyright © 2020 Zl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ZlHUDKit.share.showTitleWith("据了解，macOS Big Sur 是近年苹果操作系统版本更迭最大的一次，它是20年来让版本号从从10到11的跃进，也是第一个苹果大胆的从iOS手机系统中借鉴融合的系统，暴露了苹果想要统一全平台的野心", self.view);
    }

}

