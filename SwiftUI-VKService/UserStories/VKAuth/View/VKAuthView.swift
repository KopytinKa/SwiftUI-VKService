//
//  VKAuthView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 14.10.2021.
//

import SwiftUI
import UIKit
import WebKit
import Combine
import SwiftKeychainWrapper
import FirebaseDatabase
import Alamofire

struct WebView: UIViewRepresentable {
    @ObservedObject var model: WebViewModel
    private let ref = Database.database().reference(withPath: "users")
    
    var url: URL
        
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        return webView
    
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
    
    class Coordinator : NSObject, WKNavigationDelegate {
        var parent: WebView
        var webViewNavigationSubscriber: AnyCancellable? = nil
        
        init(_ uiWebView: WebView) {
            self.parent = uiWebView
        }
        
        deinit {
            webViewNavigationSubscriber?.cancel()
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
                decisionHandler(.allow)
                return
            }
            
            let params = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce([String: String]()) { result, param in
                    var dict = result
                    let key = param[0]
                    let value = param[1]
                    dict[key] = value
                    return dict
            }
            
            guard let token = params["access_token"], let userId = params["user_id"] else {
                decisionHandler(.allow)
                return
            }
            
            
            KeychainWrapper.standard.set(token, forKey: "token")
            Session.shared.token = token

            UserDefaults.standard.set(userId, forKey: "userId")
            Session.shared.userId = userId

            let user = FirebaseUser(id: userId)
            let userRef = self.parent.ref.child(userId)
            userRef.setValue(user.toAnyObject())

            self.parent.model.shouldRedirectToLoginView = true
            decisionHandler(.cancel)
        }
    }
}

struct VKAuthView: View {
    @ObservedObject var model: WebViewModel
    
    func getAuthUrl() -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7994567"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "response_type", value: "token"),
        ]
        
        return urlComponents.url!
    }
    
    var body: some View {
        let url = getAuthUrl()
        WebView(model: model, url: url)
    }
}
