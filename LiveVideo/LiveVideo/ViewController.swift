//
//  ViewController.swift
//  LiveVideo
//
//  Created by Fengtf on 2017/3/3.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://tv.cctv.com/live/cctv1/")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)

    }
    @IBAction func change() {
        let url = URL(string: "http://tv.cctv.com/live/cctv6/")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("webViewDidFinishLoad")

        let jsStr = "document.documentElement.getElementsByTagName(\"video\")[0].play()"
        webView.stringByEvaluatingJavaScript(from: jsStr)
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {

        print(request)



        return true
    }


}

