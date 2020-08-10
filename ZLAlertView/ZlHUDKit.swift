//
//  ZlHUDKit.swift
//  jingxin
//
//  Created by Yuki on 2020/8/10.
//  Copyright © 2020 Zl. All rights reserved.
//  弹框 有动画的

import UIKit
class ZlHUDKit: NSObject {
    static public var share = ZlHUDKit();//单利初始化
    
    //是否显示了
    private var isShow = Bool() ;
    //最大宽度
    private let maxWidth = UIScreen.main.bounds.size.width - 60.0;
    
    
    //MARK:显示文案
//    public  func showTitle(_ title:String) {
//        showStr(title);
//    }
    
    /**  显示文字  **/
    public func showTitleWith(_ title:String ,_ superView:UIView){
        showStr(title, superView);
    }
    
    
    /**  添加到主界面  **/
    private func showStr(_ str:String, _ superView:UIView){
        if self.isShow == true  {
            return ;
        }
        self.loadView.center = superView.center;
        self.loadView.bounds = CGRect.init(x: 0, y: 0, width: CGFloat(getStrSizeWidth(str,.systemFont(ofSize: 17)).width + 20), height: CGFloat(getStrSizeWidth(str, .systemFont(ofSize: 17)).height + 20));
        self.loadView.addSubview(self.titleLb);
        
        self.titleLb.text = str;
        self.titleLb.center = CGPoint.init(x: self.loadView.bounds.size.width/2, y: self.loadView.bounds.size.height/2);
        self.titleLb.bounds = CGRect.init(x: 0, y: 0, width: getStrSizeWidth(str, .systemFont(ofSize: 17)).width, height: getStrSizeWidth(str, .systemFont(ofSize: 17)).height)
        superView.addSubview(self.loadView);
        
        /**  做动画  **/
        animation_spread(self.loadView);
    }
    
//    /**  添加到主界面  **/
//    private func showStr(_ str:String){
//        if self.isShow == true  {
//            return ;
//        }
//        let window = (UIApplication.shared.delegate?.window) ?? (UIWindow.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))) ;
//        
//        self.loadView.center = window?.center as! CGPoint;
//        self.loadView.bounds = CGRect.init(x: 0, y: 0, width: CGFloat(getStrSizeWidth(str,.systemFont(ofSize: 17)).width + 20), height: CGFloat(getStrSizeWidth(str, .systemFont(ofSize: 17)).height + 20));
//        self.loadView.addSubview(self.titleLb);
//        
//        self.titleLb.text = str;
//        self.titleLb.center = CGPoint.init(x: self.loadView.bounds.size.width/2, y: self.loadView.bounds.size.height/2);
//        self.titleLb.bounds = CGRect.init(x: 0, y: 0, width: getStrSizeWidth(str, .systemFont(ofSize: 17)).width, height: getStrSizeWidth(str, .systemFont(ofSize: 17)).height)
//        window?.addSubview(self.loadView);
//        
//        /**  做动画  **/
//        animation_spread(self.loadView);
//        
//    }
//    
    
    //MARK:动画
    /**  展开显示动画 **/
    private func animation_spread(_ animationView:UIView){
        self.isShow = true;
        let animation = CABasicAnimation(keyPath: "transform.scale");
        animation.fromValue = 0.5;
        animation.toValue = 1;
        animation.duration = 0.20;
        animation.autoreverses = false;
        animation.repeatCount = 1;
        animation.isRemovedOnCompletion = false;
        animation.fillMode = .forwards;
        animationView.layer.add(animation, forKey: "xxx");
        /**  开启定时器，2秒后关闭动画  **/
        self.perform(#selector(animation_willClose), with: animationView, afterDelay: 2)
    }
    
    /**  将要关闭隐藏动画  **/
    @objc private func animation_willClose(_ animationView:UIView){
        /**  动画1  **/
        let animation = CABasicAnimation(keyPath: "transform.scale");
        animation.fromValue = 1;
        animation.toValue = 0.75;
        animation.duration = 0.20;
        animation.autoreverses = false;
        animation.repeatCount = 1;
        animation.isRemovedOnCompletion = false;
        animation.fillMode = .forwards;
        animationView.layer.add(animation, forKey: "xxx");
        /**  开启定时器，2秒后关闭动画  **/
        self.perform(#selector(animation_didClose(_:)), with: animationView, afterDelay: 1)
    }
    
    /**  关闭隐藏动画  **/
    @objc private func animation_didClose(_ animationView:UIView){
        /**  动画1  **/
        let animation = CABasicAnimation(keyPath: "transform.scale");
        animation.fromValue = 0.75;
        animation.toValue = 0.5;
        animation.duration = 0.20;
        animation.autoreverses = false;
        animation.repeatCount = 1;
        animation.isRemovedOnCompletion = false;
        animation.fillMode = .forwards;
        animationView.layer.add(animation, forKey: "xxx");
        self.isShow = false;
        animationView.removeFromSuperview();
    }
    
    
    
    //MARK:工具
    //获取文本的宽度
    private func getStrSizeWidth(_ str:String,_ font:UIFont) -> CGSize{
        let lb = UILabel.init();
        lb.text = str;
        lb.font = font;
        let size = lb.sizeThatFits(CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: font.lineHeight));
        
        //限制下最大宽度
        if size.width > maxWidth {
            let lb = UILabel.init();
            lb.text = str;
            lb.font = font;
            lb.numberOfLines = 0;
            let size2 = lb.sizeThatFits(CGSize.init(width: maxWidth, height: CGFloat.greatestFiniteMagnitude));
            
            return size2;
        }
        
        return size;
    }
    
    
    //MARK:lazy
    /**  文本显示控件  **/
    private lazy var titleLb :UILabel = {
        var titleLb = UILabel.init();
        titleLb.font = .systemFont(ofSize: 15);
        titleLb.textAlignment = .center;
        titleLb.textColor = .white;
        titleLb.numberOfLines = 0;
        return titleLb;
    }();
    
    /**  载体view  **/
    private lazy var loadView :UIView = {
        var loadView = UIView.init();
        loadView.backgroundColor = UIColor.black;
        loadView.layer.cornerRadius = 4;
        loadView.layer.masksToBounds = true;
        return loadView;
    }();
    
    
    
}
