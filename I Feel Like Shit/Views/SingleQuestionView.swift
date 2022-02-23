//
//  SingleQuestionView.swift
//  I Feel Like Shit
//
//  Created by Ivette Fernandez on 2/22/22.
//

import SwiftUI

struct SingleQuestionView: View {
    
    let question: Question
    
    @State private var showQuestion: Bool = false
    
    var body: some View {
        Toggle(isOn: $showQuestion) {
            Text(question.text!)
        }
        .tint(.blue)
        .padding(.horizontal, 10.0)
    }
}

//struct SingleQuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleQuestionView()
//    }
//}
