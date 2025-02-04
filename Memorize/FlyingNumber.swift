//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Zheen Suseyi on 2/4/25.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
