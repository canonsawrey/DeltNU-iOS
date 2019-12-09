//  MinutesWebView.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/24/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//
import SwiftUI
import WebKit

struct MasterformWebView: View {
    let minutes: Minute
    let url: URL?
    
    var body: some View {
        Group {
            if url != nil {
                WebView(request: URLRequest(url: url!))
            } else {
                Text("Link is busted!")
            }
        }
    }
    
    init(minutes: Minute) {
        self.minutes = minutes
        self.url = URL(string: minutes.masterform)
    }
}

struct MasterformWebView_Previews: PreviewProvider {
    static let minutes: Minutes = Bundle.main.decode("minutes.json")
    
    static var previews: some View {
        MasterformWebView(minutes: self.minutes[0])
    }
}
  
struct WebView : UIViewRepresentable {
      
    let request: URLRequest
      
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
      
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
      
}
  
struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "https://www.apple.com")!))
    }
}
