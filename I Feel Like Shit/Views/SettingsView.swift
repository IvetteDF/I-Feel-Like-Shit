//
//  SettingsView.swift
//  I Feel Like Shit
//
//  Created by Ivette Fernandez on 2/21/22.
//

import SwiftUI
import CoreData

struct SettingsView: View {
    
    let coreDM: CoreDataManager
    let persistentContainer: NSPersistentContainer
    
    @State private var newQuestionText: String = ""
    @State private var isOn: Bool = false
    @State private var questions: [Question] = []
    
    private func makeQuestion(questionText: String) -> Question {
        let question = Question(context: persistentContainer.viewContext)
        question.text = questionText
        question.defaultQuestion = true
        return question
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(0.01)
                .frame(idealWidth: .infinity, idealHeight: .infinity)
                .onAppear {
                    questions = coreDM.getAllQuestions()
                }
            VStack {
                Text("Questions")
                    .font(.largeTitle)
                ForEach(DefaultQuestions.list, id:\.self) { questionText in
                    SingleQuestionView(question: makeQuestion(questionText: questionText))
                }
                List {
                    ForEach(questions) { question in
                        SingleQuestionView(question: question)
                    }   .onDelete { IndexSet in
                        IndexSet.forEach { index in
                            coreDM.deleteQuestion(question: questions[index])
                            questions = coreDM.getAllQuestions()
                        }
                    }
                }
                TextField("New question here", text: $newQuestionText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.all, 10.0)
                Button("Add Question") {
                    coreDM.saveQuestion(text: newQuestionText)
                    questions = coreDM.getAllQuestions()
                }
            }
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(coreDM: CoreDataManager())
//    }
//}
