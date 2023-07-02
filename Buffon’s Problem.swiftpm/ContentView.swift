import SwiftUI
import Foundation

struct ContentView: View {
    @State var started = false
    @State var linesHeight = 0.0
    @State var bgAnimation = false
    @State var currentShowed : Int = 0
    @State var steps : [CGFloat] = [0.2, 0.4, 0.6, 0.8]
    @State var pi : Double = 0.0
    @State var drawNeedles : Bool = false
    @State var needles : [Needle] = []
    @State var hitsCounter: Int = 0
    let timer = Timer.publish(every: 0.035, on: .main, in: .common).autoconnect()
    @State var startPiCalc = true
    
    /*
     withAnimation{
         for _ in 0..<100{
             needlesNumber += 1
         }
     } */
    
    
    
    let cfURL = Bundle.main.url(forResource: "CourierPrime-Regular", withExtension: "ttf")! as CFURL
    let cfURL2 = Bundle.main.url(forResource: "CourierPrime-Bold", withExtension: "ttf")! as CFURL
    let cfURL3 = Bundle.main.url(forResource: "CourierPrime-Italic", withExtension: "ttf")! as CFURL
    
    init() {
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        CTFontManagerRegisterFontsForURL(cfURL2, CTFontManagerScope.process, nil)
        CTFontManagerRegisterFontsForURL(cfURL3, CTFontManagerScope.process, nil)
        
        
    }
    
    
    var body: some View {
        GeometryReader{ geo in
            
            let screen_w = geo.size.width
            let screen_h = geo.size.height
            let fontSmall = Font.custom("CourierPrime-Regular", size: screen_w * 0.022)
            let font = Font.custom( "CourierPrime-Regular", size:  screen_w * 0.03)
            let fontTitle = Font.custom( "CourierPrime-Regular", size:  screen_w * 0.04)
            let fontLargeTitle = Font.custom( "CourierPrime-Regular", size:  screen_w * 0.06)
            
            let fontTitleBold = Font.custom( "CourierPrime-Bold", size:  screen_w * 0.04)
            let fontLargeTitleBold = Font.custom( "CourierPrime-Bold", size:  screen_w * 0.06)
            
            let column_width = screen_w * 0.25
            let length = column_width / 2
            
            
            VStack {
                HStack{
                    VStack(spacing: 0.0){
                        
                        Text("Buffon's needle problem")
                            .font(started ? fontTitleBold : fontLargeTitleBold)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: started ? .leading : .center)
                            .padding(.horizontal, started ? screen_w*0.025 : 0.0)
                            .padding(.vertical, started ? screen_w*0.025 : 0.0)
                        
                    }
                    
                    if currentShowed == 3 {
                        VStack{
                            Text("π = \(pi)")
                                .font(fontTitle)
                                .italic()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, screen_w * 0.02)
                            
                            Text("Needles used: \(needles.count)")
                                .font(fontSmall)
                                .italic()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Hits: \(hitsCounter)")
                                .font(fontSmall)
                                .italic()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                        }
                        .padding(.trailing)
                        .frame(maxWidth: screen_w * 0.35)
                    }
                }
                
                if !started {
                    Button{
                        withAnimation{
                            started.toggle()
                        }
                        withAnimation(.linear(duration: 1.5)){
                            bgAnimation = started ? true : false
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(uiColor: .systemYellow))
                                .shadow(radius: 10, x: 5, y: 5)
                            Text("Let's start")
                                .padding(.horizontal, screen_w * 0.02)
                                .padding(.vertical, screen_h * 0.007)
                                .font(font)
                                .foregroundColor(.black)
                        }
                        .frame(width: screen_w * 0.25, height: screen_h * 0.025)
                    }
                } else {
                    ZStack{
                        Circle()
                            .frame(maxWidth: bgAnimation ? .infinity : 0.0, maxHeight: bgAnimation ? .infinity : 0.0)
                            .scaleEffect(5)
                            .foregroundColor(Color(uiColor: .systemYellow))
                        
                            ScrollViewReader{ reader in
                                ScrollView{
                                    VStack(spacing: screen_h*0.2){
                                        FirstView(screen_w: screen_w, currentShowed: $currentShowed, fontLargeTitle: fontLargeTitle, fontTitle: fontTitle, font: font)
                                            .id(0)
                                        
                                        SecondView(screen_w: screen_w, currentShowed: $currentShowed, fontLargeTitle: fontLargeTitle, fontTitle: fontTitle, font: font)
                                            .id(1)
                                        
                                        ThirdView(screen_w: screen_w, currentShowed: $currentShowed, fontLargeTitle: fontLargeTitle, fontTitle: fontTitle, font: font, linesHeight: $linesHeight, drawNeedles: $drawNeedles)
                                            .id(2)
                                        
                                        VStack{
                                            HStack{
                                                Spacer()
                                                Actions(font: font, screen_w: screen_w, piCalc: $startPiCalc, hits: $hitsCounter, ndls: $needles, pie: $pi)
                                                Spacer()
                                                Button{
                                                    withAnimation{
                                                        currentShowed = currentShowed - 1
                                                    }
                                                } label: {
                                                    HStack{
                                                        Text("Back")
                                                        Image(systemName: "chevron.up")
                                                    }
                                                    .font(font)
                                                    .italic()
                                                    .padding(.trailing)
                                                    .foregroundColor(Color(uiColor: .systemBlue))
                                                }
                                                
                                            }
                                            .frame(maxWidth: .infinity,alignment: .trailing)
                                            
                                            
                                            
                                            
                                            ZStack{
                                                BackgroundLines()
                                                    .trim(from: 0.0, to: linesHeight)
                                                    .stroke(.black, lineWidth: 2.5)
                                                    .frame(width: screen_w)
                                                    
                                                if drawNeedles{
                                                    ForEach(needles, id: \.self){ needle in
                                                        needle
                                                            .stroke(needle.stroke, lineWidth: needle.stroke == .black ? 1 : 3)
                                                            .frame(width: needle.length, height: needle.length)
                                                            .rotationEffect(Angle(degrees: needle.angle), anchor: .center)
                                                            .position(x: needle.x, y: needle.y)
                                                    }
                                                }
                                            }
                                            .frame(width: screen_w, height: screen_h * 0.85)
                                            .overlay(Rectangle().stroke(.black, lineWidth: 2))
                                            .clipShape(Rectangle())
                                            .onReceive(timer) { _ in
                                                
                                                    if drawNeedles && startPiCalc {
                                                        let x = CGFloat(arc4random_uniform(UInt32(screen_w)))
                                                        let y = CGFloat(arc4random_uniform(UInt32(screen_h * 0.85)))

                                                        let angle = CGFloat(arc4random_uniform(180))
                                                        
                                                        let stroke = getStrokeColor(center: x, column_width: column_width, angle: angle, length: length)
                                                        
                                                        needles.append(Needle(length: length, x: x, y: y, stroke: stroke, angle: angle))
                                                        
                                                        if needles.count > 0{
                                                            let prob =  Double(hitsCounter) / Double(needles.count)
                                                            self.pi = (2.0 * length) / (prob * column_width)
                                                        }
                                                    }
                                                
                                            }
                                        }
                                        .id(3)
                                     
                                    }
                                }
                                .onChange(of: currentShowed, perform: { newValue in
                                    withAnimation {
                                        reader.scrollTo(newValue, anchor: .top)
                                    }
                                })
                                .scrollDisabled(true)
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(Rectangle())
                    .ignoresSafeArea(.all)
                    
                
                }
                
                    
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: started ? .top :  .center)
            .background( LinearGradient(
                colors: [
                    Color(uiColor: .systemGray6),
                    Color(uiColor: .systemGray3),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            )
           
        }
        
    }
    
    
    
    
    
    
    func getStrokeColor(center: CGFloat, column_width: CGFloat, angle: CGFloat, length: CGFloat) -> Color {
        let radians = angle * .pi / 180
        let closest = (center / column_width).rounded()
        let dist = abs(closest * column_width - center)
        
        var strokeColor = Color.black
        
        if dist <= (length * sin(abs(radians)) / 2)  {
            hitsCounter += 1
            strokeColor = Color(uiColor: .systemPurple)
        }
        
        return strokeColor
    }
    
}


struct BackgroundLines : Shape {
    func path(in rect: CGRect) -> Path {
        Path{ path in
            let w = rect.size.width
            let h = rect.size.height
            
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: h))
            
            path.move(to: CGPoint(x: w*0.25, y: 0))
            path.addLine(to: CGPoint(x: w*0.25, y: h))
            
            path.move(to: CGPoint(x: w*0.5, y: 0))
            path.addLine(to: CGPoint(x: w*0.5, y: h))
            
            path.move(to: CGPoint(x: w*0.75, y: 0))
            path.addLine(to: CGPoint(x: w*0.75, y: h))
            
            path.move(to: CGPoint(x: w, y: 0))
            path.addLine(to: CGPoint(x: w, y: h))
            
            
        }
    }
    
    
}

struct Needle: Shape, Hashable{
    
    let id = UUID()
    let length: CGFloat
    let x: CGFloat
    let y: CGFloat
    let stroke: Color
    let angle : CGFloat
    
    
    
    
    func path(in rect: CGRect) -> Path {
        Path{ path in
            let centerX = rect.size.width / 2
            let centerY = rect.size.height / 2
            
            path.move(to: CGPoint(x: centerX, y: centerY))
            path.addLine(to: CGPoint(x: centerX, y: centerY - length / 2))
            
            path.move(to: CGPoint(x: centerX, y: centerY))
            path.addLine(to: CGPoint(x: centerX, y: centerY + length / 2))
        }
    }
}


struct Actions: View{
    
    let font: Font
    let screen_w : CGFloat
    @Binding var piCalc : Bool
    @Binding var hits : Int
    @Binding var ndls : [Needle]
    @Binding var pie : Double
    
    
    var body: some View{
        HStack{
            Button {
                piCalc = true
            } label: {
                Image(systemName: "play.fill")
                    .font(font)
                    .foregroundColor(.white)
                    .padding(screen_w*0.008)
                    .background(Color(uiColor: .systemGreen), in: RoundedRectangle(cornerRadius: 10))
            }
            
            Button {
                piCalc = false
            } label: {
                Image(systemName: "stop.fill")
                    .font(font)
                    .foregroundColor(.white)
                    .padding(screen_w*0.008)
                    .background(Color(uiColor: .systemRed), in: RoundedRectangle(cornerRadius: 10))
            }
            
            Button {
                piCalc = false
                hits = 0
                ndls = []
                pie = 0.0
                
            } label: {
                Image(systemName: "xmark")
                    .font(font)
                    .foregroundColor(.white)
                    .padding(screen_w*0.008)
                    .background(Color(uiColor: .systemBlue), in: RoundedRectangle(cornerRadius: 10))
            }
        }
        
    }
}
