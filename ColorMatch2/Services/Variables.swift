//
//  Variables.swift
//  ColorMatch2
//
//  Created by Akerke on 22.10.2023.
//

import SwiftUI

class Variables: ObservableObject{
    
    @Published var playerNameInput: String = ""
    @Published  var isNameInputViewPresented: Bool = false
    
    @Published  var isInfoViewPresented = false
    @Published  var ellipseOneWidth: CGFloat = 200
    @Published  var ellipseOneHeight: CGFloat = 200
}

