//
//  SecondView.swift
//  My App
//
//  Created by Gaetano Celentano on 07/04/23.
//

import SwiftUI

struct SecondView: View {
    
    @State var screen_w : CGFloat
    @Binding var currentShowed : Int
    @State var fontLargeTitle : Font
    @State var fontTitle : Font
    @State var font : Font
    
    
    
    var body: some View {
        VStack{
            Button{
                currentShowed = currentShowed - 1
            } label: {
                HStack{
                    Text("Back")
                    Image(systemName: "chevron.up")
                }
                .font(font)
                .italic()
                .padding(.trailing)
                .padding(.top)
                .foregroundColor(Color(uiColor: .systemBlue))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            Text("**This can be used to design a 'Monte Carlo method' for approximating the number π**, although that was not the original motivation for de Buffon's question.")
                .font(fontTitle)
                .foregroundColor(.black)
                .frame(maxWidth: screen_w * 0.9, alignment: .leading)
                .lineLimit(nil)
                .padding()
            Text("\nSupposing that the maximum length of a needle is not greater than the distance between two lines, we can say that the end of the needle farthest away from any one of the two lines bordering its region must be located within a horizontal (perpendicular to the bordering lines) distance of **l*cosθ** (where _θ_ is the angle between the needle and the horizontal) from this line in order for the needle to cross it.\nThe farthest this end of the needle can move away from this line horizontally in its region is _t_. The probability that the farthest end of the needle is located no more than a distance _l*cosθ_ away from the line (and thus that the needle crosses the line) out of the total distance _t_ it can move in its region for 0 ≤ θ ≤ π/2 is given by")
                .font(font)
                .foregroundColor(.black)
                .frame(maxWidth: screen_w * 0.9, alignment: .leading)
                .lineLimit(nil)
            HStack{
                Image("Integral")
                    .scaleEffect(screen_w*0.0008)
            }
            .frame(width: screen_w)
            
            
            Button{
                withAnimation {
                    currentShowed = 2
                }
            } label: {
                HStack{
                    Text("But… where's pi?")
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

/*struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
*/
