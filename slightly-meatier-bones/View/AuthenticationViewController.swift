//
//  AuthenticationViewController.swift
//  slightly-meatier-bones
//
//  Created by keckuser on 4/2/23.
//

import SwiftUI
import UIKit

import FirebaseAuthUI

struct AuthenticationViewController: UIViewControllerRepresentable {
    var authUI: FUIAuth
    
    func makeUIViewController (context: Context) -> UINavigationController {
        return authUI.authViewController()
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Leave this blank because we do not do updates
    }
}
