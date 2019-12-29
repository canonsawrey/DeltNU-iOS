//
//  SceneDelegate.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/22/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        let showApplication: () -> Void = {
            // Use a UIHostingController as window root view controller.
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                let hostingController = UIHostingController(rootView: SessionView())
                window.rootViewController = hostingController
                self.window = window
                window.makeKeyAndVisible()
            }
        }
        // Check to see if there are existing credentials
        let credentials = DefaultCredentialCache().getCachedCredentials()
        guard let validCredentials = credentials.getCredentials() else {
            showApplication()
            return
        }
        let authentication = DefaultAuthRemote()
        var disposables = Set<AnyCancellable>()
        authentication.authenticate(credential: validCredentials)
        .sink(
            receiveCompletion: {  value in //[weak self] completion in
                switch value {
                case .failure:
                    print("fail")
                case .finished:
                    break
                }
        },
            receiveValue: { _ in
                self.setupSession(cred: validCredentials)
        })
    }
    
    private func setupSession(cred: Credential) {
        let userRepository = DefaultUserRepository()
        let dir = DefaultDirectoryCache()
        let session = Session.shared
        
        session.fillCaches(userEmail: cred.email)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    //TODO handle these
                    case .failure:
                        break
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] cacheResponse in
                    guard let self = self else { return }
                    //TODO this prrooooobably should live elsewhere and its pretty ugly
                    userRepository.setUser(user: dir.getUser(email: cred.email))
                    if let windowScene = self.scene as? UIWindowScene {
                        let window = UIWindow(windowScene: windowScene)
                        let hostingController = UIHostingController(rootView: SessionView())
                        window.rootViewController = hostingController
                        self.window = window
                        window.makeKeyAndVisible()
                    }
                    withAnimation {
                        session.activeSession = true
                    }
                    
            })
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

