//
//  ContentView.swift
//  I Feel Like Shit
//
//  Created by Ivette Fernandez on 2/19/22.
//

//before [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//after [0, 7, 4, 10, 5, 6, 3, 8, 9, 2, 1]

import SwiftUI
import CoreData

struct ContentView: View {
    
    let coreDM: CoreDataManager
    
    enum pageState {
        case questions
        case figuredOut
        case settings
    }
    
    @State private var question: String = ""
    @State private var randomInts: [Int] = []
    @State private var currentIndex: Int = 0
    @State private var pageState: pageState = .questions
        
    private func pickQuestion() {
        if currentIndex >= DefaultQuestions.list.count {
            currentIndex = 0
        } else {
            question = DefaultQuestions.list[randomInts[currentIndex]]
            currentIndex += 1
        }
    }
    
    private func randomizer() {
        for index in 0..<DefaultQuestions.list.count {
            randomInts.append(index)
        }
        randomInts.shuffle()
    }
    
    private func clearRandomInts() {
        randomInts.removeAll()
    }
    
    var body: some View {
        
        switch self.pageState {
        case .questions:
            // *** should probably refactor this to be its own View and view file
            VStack {
                Spacer()
                Text(question)
                    .font(.title)
                    .gesture(
                        LongPressGesture(minimumDuration: 1)
                            .onEnded { _ in
                                self.pageState = .settings
                            }
                    )
                Spacer()
                HStack {
                    Button("Yes") {
                        self.pageState = .figuredOut
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
            }   .transition(AnyTransition.scale.animation(.easeInOut(duration: 0.5)))
        case .figuredOut:
            ZStack{
                FiguredOutView()
                ConfettiView()
            }   .transition(AnyTransition.scale.animation(.easeInOut(duration: 0.5)))
                .onTapGesture(count: 2) {
                    self.pageState = .questions
                }
        case .settings:
            SettingsView(coreDM: CoreDataManager(), persistentContainer: NSPersistentContainer(name: "QuestionModel"))
                .transition(AnyTransition.scale.animation(.easeInOut(duration: 0.5)))
                .onTapGesture(count: 2) {
                    self.pageState = .questions
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
