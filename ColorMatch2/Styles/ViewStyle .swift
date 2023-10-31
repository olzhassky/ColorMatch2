//
//  ViewStyle .swift
//  ColorMatch2
//
//  Created by Akerke on 31.10.2023.
//

import Foundation
import SwiftUI


struct ViewStyleForSmallText {
    static func styledView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color.white.opacity(0.5))
            .overlay( content())
            
    }
}
