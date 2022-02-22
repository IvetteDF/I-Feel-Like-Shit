//
//  CoreDataManager.swift
//  I Feel Like Shit
//
//  Created by Ivette Fernandez on 2/20/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "QuestionModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func deleteQuestion(question: Question) {
        
        persistentContainer.viewContext.delete(question)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func getAllQuestions() -> [Question] {
        
        let fetchRequest: NSFetchRequest<Question> = Question.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func saveQuestion(text: String) {
        
        let question = Question(context: persistentContainer.viewContext)
        question.text = text
        question.id = UUID()
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save question \(error)")
        }
    }
}
