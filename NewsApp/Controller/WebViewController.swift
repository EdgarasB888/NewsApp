//
//  WebViewController.swift
//  NewsApp
//
//  Created by iMac on 2022-08-25.
//

import UIKit
import WebKit

class WebViewController: UIViewController
{
    @IBOutlet weak var webView: WKWebView!
    var urlString = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.title = "Web"
        guard let url = URL(string: urlString) else {return}
        webView.load(URLRequest(url: url))
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
