//
//  ThirdView.swift
//  My App
//
//  Created by Gaetano Celentano on 07/04/23.
//

import SwiftUI

struct ThirdView: View {
    
    
    @State var screen_w : CGFloat
    @Binding var currentShowed : Int
    @State var fontLargeTitle : Font
    @State var fontTitle : Font
    @State var font : Font
    @Binding var linesHeight : Double
    @Binding var drawNeedles : Bool
    
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
            
            Text("Simply enough, you just have to _rearrange the probability equation_, thus getting")
                .font(fontTitle)
                .foregroundColor(.black)
                .frame(maxWidth: screen_w * 0.9, alignment: .leading)
                .lineLimit(nil)
                .padding()
            HStack{
                Image("pi1")
                    .scaleEffect(screen_w*0.00065)
            }
            .frame(width: screen_w)
            
            Text("Thus, if we conduct an experiment to estimate P, we will also have an estimate for π. Suppose we drop n needles and find that h of those needles are crossing lines, so P is approximated by the fraction h / n. This leads to the formula:")
                .font(font)
                .foregroundColor(.black)
                .frame(maxWidth: screen_w * 0.9, alignment: .leading)
                .lineLimit(nil)
            
            HStack{
                Image("pi2")
                    .scaleEffect(screen_w*0.00065)
            }
            .frame(width: screen_w)
            HStack{
                Text("Font:")
                Link(destination: URL(string: "https://en.wikipedia.org/wiki/Buffon%27s_needle_problem")!) {
                    Text("Wikipedia's Article on Buffon's needle problem")
                }
                .foregroundColor(Color(uiColor: .systemBlue))
            }
            
            Button{
                withAnimation {
                    currentShowed = 3
                }
                withAnimation(.linear(duration: 2)){
                    linesHeight = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    drawNeedles = true
                    
                }
                
            } label: {
                HStack{
                    Text("Show me!!")
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
/*
struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
*/
