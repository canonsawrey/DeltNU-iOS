//
//  ViewExtensions.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/23/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct TileButton: View {
    let action: () -> ()
    let text: String
    let color: Color
    let textColor: Color
    
    
    var body: some View {
        Button(action: self.action) {
            VStack {
                Text(self.text)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(self.textColor)
                    .background(self.color)
                    .cornerRadius(appStyle.cornerRadius)
                
            }.padding()
        }
    }
    
    init(action: @escaping () -> (), text: String, color: Color, textColor: Color) {
        self.action = action
        self.text = text
        self.color = color
        self.textColor = textColor
    }
    
    init(text: String, color: Color, textColor: Color) {
        self.init(action: { }, text: text, color: color, textColor: textColor)
    }
}

struct Tile: View {
    let text: String
    let color: Color
    let textColor: Color
    var height: CGFloat = .infinity
    var width: CGFloat = .infinity
    
    var body: some View {
        Text(self.text)
            .frame(maxWidth: self.width, maxHeight: self.height)
            .foregroundColor(self.textColor)
            .background(self.color)
            .cornerRadius(appStyle.cornerRadius)
            .padding()
    }
    
    init(text: String, color: Color, textColor: Color) {
        self.text = text
        self.color = color
        self.textColor = textColor
    }
    
    init(text: String, color: Color, textColor: Color, width: CGFloat, height: CGFloat) {
        self.init(text: text, color: color, textColor: textColor)
        self.width = width
        self.height = height
    }
}

struct MainButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
                .foregroundColor(Color("colorOnSecondary"))
            .background(Color("secondary"))
            .cornerRadius(appStyle.cornerRadius)
    }
}

struct KeyboardHost<Content: View>: View {
    let view: Content

    @State private var keyboardHeight: CGFloat = 0

    private let showPublisher = NotificationCenter.Publisher.init(
        center: .default,
        name: UIResponder.keyboardWillShowNotification
    ).map { (notification) -> CGFloat in
        if let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
            return rect.size.height
        } else {
            return 0
        }
    }

    private let hidePublisher = NotificationCenter.Publisher.init(
        center: .default,
        name: UIResponder.keyboardWillHideNotification
    ).map {_ -> CGFloat in 0}

    // Like HStack or VStack, the only parameter is the view that this view should layout.
    // (It takes one view rather than the multiple views that Stacks can take)
    init(@ViewBuilder content: () -> Content) {
        view = content()
    }

    var body: some View {
        VStack {
            view
            Rectangle()
                .frame(height: keyboardHeight)
                .animation(.default)
                .foregroundColor(.clear)
        }.onReceive(showPublisher.merge(with: hidePublisher)) { (height) in
            self.keyboardHeight = height
        }
    }
} 

struct UserView: View {
    var member: Member?
    var size: CGFloat
    
    init(member: Member?, size: CGFloat) {
        self.member = member
        self.size = size
    }
    
    var body: some View {
        ZStack {
            if (member == nil || member?.pictureURL == "/images/medium/picture.png") {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
            } else {
                RemoteImageView(withURL: EndpointApi.baseUrl + member!.pictureURL, size: self.size)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: appStyle.cornerRadius))
        .frame(maxWidth: self.size, maxHeight: self.size)
    }
}

struct RemoteImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    var size: CGFloat

    init(withURL url:String, size: CGFloat) {
        imageLoader = ImageLoader(urlString:url)
        self.size = size
    }

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }.onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
