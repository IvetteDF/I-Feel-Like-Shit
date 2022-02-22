//
//  ContentView.swift
//  I Feel Like Shit
//
//  Created by Ivette Fernandez on 2/19/22.
//

import SwiftUI

struct ContentView: View {
    
    let coreDM: CoreDataManager
    
    @State private var question: String = ""
    @State private var randomInts: [Int] = []
    @State private var currentIndex: Int = 0
    @State private var figuredOut: Bool = false
    
    private func pickQuestion() {
        if currentIndex >= Questions.list.count {
            currentIndex = 0
        } else {
            question = Questions.list[currentIndex]
            currentIndex += 1
        }
    }
    
    private func randomizer() {
        for index in 0..<Questions.list.count {
            randomInts.append(index)
        }
        randomInts.shuffle()
    }
    
    private func clearRandomInts() {
        randomInts.removeAll()
    }
    
    var body: some View {
        if figuredOut {
            FiguredOutView()
            ConfettiView()
        } else {
            VStack {
                Spacer()
                Text(question)
                    .font(.title)
                Spacer()
                HStack {
                    Button("Yes") {
                        figuredOut.toggle()
                    }
                        .padding()
                        .frame(width: 100)
                        .font(.headline)
                        .background(.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    Button("No") {
                        pickQuestion()
                    }
                        .padding()
                        .frame(width: 100)
                        .font(.headline)
                        .background(.red)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }   .onAppear {
                    randomizer()
                    pickQuestion()
                    }
                Spacer()
            }
        }
    }
}

struct Questions {
    static let list: [String] = [
    "Am I hungry?",
    "Is my period starting soon?",
    "Am I thirsty?",
    "Am I sleepy?",
    "Am I too hot?",
    "Am I too cold?",
    "Am I sore?",
    "Am I bored?",
    "Am I avoiding something?"
    ]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
