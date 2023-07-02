//
//  FirstView.swift
//  My App
//
//  Created by Gaetano Celentano on 07/04/23.
//

import SwiftUI

struct FirstView: View {
    
    @State var screen_w : CGFloat
    @Binding var currentShowed : Int
    @State var fontLargeTitle : Font
    @State var fontTitle : Font
    @State var font : Font
    
    
    var body: some View {
        VStack{
            Text("What is that?")
                .font(fontLargeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding()
                .padding(.top)
            Text("In mathematics, **Buffon's needle problem** is a question first posed in the 18th century by Georges-Louis Leclerc, Comte de _Buffon_.\nBuffon's needle was the earliest problem in geometric probability to be solved. Suppose we have a floor made of parallel strips of wood, each the same width, and we drop a needle onto the floor.\nWhat is the probability that the needle will lie across a line between two strips?\nThe solution for the sought probability _'p'_, in the case where the needle length _'l'_ is not greater than the width _'t'_ of the strips, is")
                .font(font)
                .foregroundColor(.black)
                .frame(maxWidth: screen_w * 0.9, alignment: .leading)
                .lineLimit(nil)
            Image("Equation")
                .scaleEffect(screen_w * 0.0007)
            Button{
                withAnimation {
                    currentShowed = 1
                }
            } label: {
                HStack{
                    Text("What does that mean?")
                    Image(systemName: "chevron.down")
                }
                .padding()
                .font(fontTitle)
                .foregroundColor(.black)
                
            }
            .frame(maxWidth: screen_w * 0.5)
        }
    }
}

/*struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}*/
