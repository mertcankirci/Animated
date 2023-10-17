//
//  HeartShape.swift
//  Animated
//
//  Created by Mertcan Kırcı on 3.08.2023.
//

import SwiftUI

struct HeartShapeView: View {
    
    @State private var startPrecent = 36.0
    @State var endPrecent : Double
    @State private var currentPrecent = 0.0
    private let animationDuration: TimeInterval = 1.8 // Animasyon süresi (saniye cinsinden)
    private let animationSteps = 250 // Adım sayısı
    
    var body: some View {
        VStack(spacing: 96) {
            HeartWaveView(startPrecent: Int(currentPrecent))
                .onAppear {
                    startAnimating()
                }
            
        }
        
    }
    
    private func startAnimating() {
        let stepSize = (endPrecent - startPrecent) / Double(animationSteps)
        var stepCount = 0
        
        Timer.scheduledTimer(withTimeInterval: animationDuration / Double(animationSteps), repeats: true) { timer in
            
                currentPrecent = startPrecent + stepSize * Double(stepCount)
                stepCount += 1
                
                if stepCount > animationSteps {
                    timer.invalidate()
                }
            
        }
    }
}


struct HeartShape: Shape {
    let scale: CGFloat
    
    init(scale: CGFloat = 1.0) {
        self.scale = scale
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for theta in stride(from: 0, to: 2 * .pi, by: 0.01) {
            let x = 16 * pow(sin(theta), 3)
            let y = 13 * cos(theta) - 5 * cos(2 * theta) - 2 * cos(3 * theta) - cos(4 * theta)
            
            let point = CGPoint(x: x, y: y)
            let scaledPoint = CGPoint(
                x: point.x * scale + rect.midX,
                y: -point.y * scale + rect.midY
            )
            
            if theta == 0 {
                path.move(to: scaledPoint)
            } else {
                path.addLine(to: scaledPoint)
            }
        }
        
        return path
    }
}









struct Wave: Shape {
    
    var offset: Angle
    var percent: Double
    
    var animatableData: Double {
        get { offset.degrees }
        set { offset = Angle(degrees: newValue) }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        
        let lowfudge = 0.02
        let highfudge = 0.98
        
        let newpercent = lowfudge + (highfudge - lowfudge) * percent
        let waveHeight = 0.015 * rect.height
        let yoffset = CGFloat(1 - newpercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offset
        let endAngle = offset + Angle(degrees: 360)
        
        p.move(to: CGPoint(x: 0, y: yoffset + waveHeight * CGFloat(sin(offset.radians))))
        
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            p.addLine(to: CGPoint(x: x, y: yoffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        p.closeSubpath()
        
        return p
    }
}

struct HeartWaveView: View {
    
    @State private var waveOffset = Angle(degrees: 0)
    let startPrecent: Int
    
    var body: some View {
        
            ZStack {
                HeartShape(scale: 2.5)
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(width: 150, height: 150)
                    .overlay(
                        Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(startPrecent)/100)
                            .fill(Color(hex: 0xf77d8e))
                            .clipShape(
                                HeartShape(scale: 2.5)
                                    .scale(0.92)
                            )
                    )
                Text("%\(self.startPrecent + 14)")
                    .foregroundColor(.white)
                    .customFont(.headline)
                    .offset(x: -4)
                    
            }

        
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
        }
    }
}


struct HeartShape_Previews: PreviewProvider {
    static var previews: some View {
        HeartShapeView(endPrecent: 46.0)
    }
}
