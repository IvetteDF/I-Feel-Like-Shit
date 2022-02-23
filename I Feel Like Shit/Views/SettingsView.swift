//
//  SettingsView.swift
//  I Feel Like Shit
//
//  Created by Ivette Fernandez on 2/21/22.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var newQuestionText: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(0.01)
                .frame(idealWidth: .infinity, idealHeight: .infinity)
            VStack {
                TextField("New question here", text: $newQuestionText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.all, 10.0)
                Button("Add Question") {
                    print(newQuestionText)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
