//
//  FiguredOutView.swift
//  I Feel Like Shit
//
//  Created by Ivette Fernandez on 2/21/22.
//

import SwiftUI

struct FiguredOutView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(0.01)
                .frame(idealWidth: .infinity, idealHeight: .infinity)
            Text("You figured it out!")
                .font(.title)
        }
    }
}

struct FiguredOutView_Previews: PreviewProvider {
    static var previews: some View {
        FiguredOutView()
    }
}
