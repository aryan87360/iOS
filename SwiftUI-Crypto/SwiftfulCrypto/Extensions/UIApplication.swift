//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by Aryan Sharma on 5/9/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
