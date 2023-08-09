//
//  ContentView.swift
//  SyncLightDemo
//
//  Created by 박채영 on 2023/08/09.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    let ref = Database.database().reference()
    
    @State private var lightOn: Bool = false
    
    var systemImageString: String {
        lightOn ? "light.max" : "light.min"
    }
    
    var lighteColor: Color {
        lightOn ? .yellow : .gray
    }
    
    var body: some View {
        VStack {
            Text("Light is")
                .font(.title)
            
            Image(systemName: systemImageString)
                .font(.largeTitle)
                .foregroundColor(lighteColor)
                .padding()
            
            Button {
                lightOn.toggle()
                ref.child("lightOn").setValue(lightOn)
            } label: {
                Text("Toggle Light")
            }
            .buttonStyle(.borderedProminent)
            .tint(lighteColor)
            .padding()
        }
        .padding()
        .onAppear {
            observeLightState()
        }
    }
    
    func observeLightState() {
        ref.child("lightOn").observe(.value) { snapshot in
            if let value = snapshot.value as? Bool {
                lightOn = value
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
