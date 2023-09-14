//
//  SlightlyMeatyAuth.swift
//  slightly-meatier-bones
//
//  Created by keckuser on 4/2/23.
//

import Foundation
import WebKit

import FirebaseAuthUI
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import FirebaseEmailAuthUI
import FirebaseGoogleAuthUI
import FirebaseOAuthUI

class SlightlyMeatyAuth: NSObject, ObservableObject, FUIAuthDelegate{
    var authUI: FUIAuth? = FUIAuth.defaultAuthUI()
    @Published var user: User?
    
    override init(){
        super.init()
        
        let providers: [FUIAuthProvider] = [
            FUIEmailAuth(),
            FUIGoogleAuth(authUI: authUI!),
            FUIGitHubAuth()
        ]
        
        authUI?.delegate = self
        authUI?.providers = providers
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?){
        if let actualResult = authDataResult {
            user = actualResult.user
        }
    }
    
    func signOut() throws {
        try authUI?.signOut()
        clearWebViewCache()
        user = nil
    }
    
    func clearWebViewCache() {
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeCookies])
        let date = Date(timeIntervalSince1970: 0)
        
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date) {
            print("Cleared WKWebView cache.")
        }
    }
    
    func signInWithGitHub(presentingViewController: UIViewController) {
        let provider = OAuthProvider(providerID: "github.com")
        provider.getCredentialWith(nil) { credential, error in
            if let error = error {
                // Handle Error
                print ("Error getting GitHub credential: \(error.localizedDescription)")
                return
            }
            
            if let credential = credential {
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        // Handle error
                        print("Firebase sign in error: \(error.localizedDescription)")
                        return
                    }
                    self.user = authResult?.user
                }
            }
        }
    }
}


class FUIGitHubAuth: FUIOAuth {
    private var customButton: UIButton?
    init() {
        let providerID = "github.com"
        let scopes: [String] = ["read:user", "user:email"]
        let customParameters = ["allow_signup": "false"]
        super.init(authUI: FUIAuth.defaultAuthUI()!, providerID: providerID, buttonLabelText: "Sign In with Github", shortName: "GitHub", buttonColor: .gray, iconImage: UIImage(named: "GitHubLogo_2.png")!, scopes: scopes, customParameters: customParameters, loginHintKey: "email")
    }
}
