//
//  SwiftUiWorkarounds.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/25/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

// Unable to style navigation bar title - NOTE: This still does not really work
struct NavBarConfig: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavBarConfig>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavBarConfig>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
}
