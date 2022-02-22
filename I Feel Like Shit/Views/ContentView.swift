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

// https://betterprogramming.pub/creating-confetti-particle-effects-using-swiftui-afda4240de6b
struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 20 ... 200)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}

struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 5.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
}

struct ConfettiView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 12, height: 12)
                .modifier(ParticlesModifier())
                .offset(x: -100, y : -50)
            
            Circle()
                .fill(Color.red)
                .frame(width: 12, height: 12)
                .modifier(ParticlesModifier())
                .offset(x: 60, y : 70)
        }
    }
}

struct FiguredOutView: View {
    var body: some View {
        Text("You figured it out!")
            .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
