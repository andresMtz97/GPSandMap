//
//  ContentView.swift
//  GPSandMap
//
//  Created by DISMOV on 15/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var lManager = LocationManager()
    
    var body: some View {
        if lManager.address != "" {
            Text(lManager.address)
        } else {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
