//
//  WebViewController.swift
//  LinkinBio
//
//  Created by Ian MacKinnon on 2016-04-18.
//  Copyright © 2016 Ian MacKinnon. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    private var urlString: String?

    override func viewDidLoad() {
        webView.navigationDelegate = self
        if let url = URL(string: urlString ?? "") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    func configure(urlString: String) {
        self.urlString = urlString
    }
}

extension WebViewController: WKNavigationDelegate {}
