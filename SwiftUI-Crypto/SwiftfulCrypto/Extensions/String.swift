//
//  String.swift
//  SwiftfulCrypto
//
//  Created by Aryan Sharma on 5/14/24.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
