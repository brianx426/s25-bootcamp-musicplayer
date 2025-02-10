//
//  MusicPlayerView.swift
//  musicplayer
//
//  Created by Brian Liu on 2/9/25.
//

import SwiftUI

struct MusicPlayerView: View {
    @State private var time: Double = 0
    @State private var volume: Double = 0
    @State private var playing: Bool = false
    let duration: Double = 181 // length of song
    
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(gradient: Gradient(colors: [Color("1"), Color("2"), Color("3"), Color("4"), Color("5")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .opacity(0.5)
                    .frame(width: 50, height: 6.5)
                    .padding(.top, 15)
                    .padding(.bottom, 30)
                
                Image("album")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(width: playing ? 365 : 265, height: playing ? 365 : 265)
                    .shadow(color: .black, radius: 12.5)
                    .padding(.bottom, playing ? 40 : 85)
                    .padding(.top, playing ? 0 : 55)

            
                HStack(alignment: .center, spacing: 4) {
                
                    VStack(alignment: .leading) {
                        Text("初雪")
                            .font(.title2)
                            .bold()
                            .padding(.leading, 20)
                            .foregroundColor(.white)
                        Text("AYANE")
                            .padding(.leading, 20)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .opacity(0.9)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 15) {
                        Image(systemName: "star.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            
                        Image(systemName: "ellipsis.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            
                    }
                    .padding(.trailing, 20)
                    .alignmentGuide(.leading) { d in d[VerticalAlignment.center] }
                }

                Slider(value: $time, in: 0...duration)
                    .padding(.horizontal, 20)
                    .accentColor(.white)
                    .font(.system(size: 25, weight: .bold))
                    .shadow(color: Color.white.opacity(0.7), radius: 1)
                    
                
                HStack {
                    Text(timeString(from: time))
                        .font(.caption)
                        .padding(.leading, 20)
                        .opacity(0.8)
                        .foregroundColor(.white)
                    Spacer()
                    Text("-" + timeString(from: duration - time))
                        .font(.caption)
                        .padding(.trailing, 20)
                        .opacity(0.8)
                        .foregroundColor(.white)
                }
                
                HStack(spacing: 75) {
                    Image(systemName: "backward.fill")
                        .resizable()
                        .frame(width: 45, height: 30)
                        .foregroundColor(.white)
                        .padding(.top, 25)
                    Button {
                        playing.toggle()
                    } label: {
                        Image(systemName: playing ? "pause.fill":"play.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .padding(.top, 25)
                    }
                    Image(systemName: "forward.fill")
                        .resizable()
                        .frame(width: 45, height: 30)
                        .foregroundColor(.white)
                        .padding(.top, 25)
                    
                }
                
                HStack {
                    Image(systemName: "speaker.fill")
                        .resizable()
                        .frame(width: 8, height: 12)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                        .padding(.leading, 20)
                        .padding(.trailing, 10)
                    Slider(value: $volume, in: 0...1)
                        .padding(.top, 30)
                        .accentColor(.white)
                        .opacity(1)
                        .font(.system(size: 25, weight: .bold))
                        .shadow(color: Color.white.opacity(0.7), radius: 1)
                    Image(systemName: "speaker.wave.3.fill")
                        .resizable()
                        .frame(width: 15, height: 12)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                        .padding(.trailing, 20)
                        .padding(.leading, 10)
                }
                .padding()
                HStack(spacing: 70) {
                    Image(systemName: "quote.bubble")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .bold))
                    
                    Image(systemName: "airpods.pro")
                        .resizable()
                        .frame(width: 30, height: 20)
                        .foregroundColor(.white)
                    
                    Image(systemName: "list.bullet")
                        .resizable()
                        .frame(width: 20, height: 15)
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .bold))
                }
                
                VStack(alignment: .center, spacing: 4) {
                    
                    Text("AirPods Pro")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 5)
                
            }
            
        }
        
        /*
        following part about the timer sourced from: https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-a-timer-with-swiftui
         */
        
        
        .onReceive(
            Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        ) { _ in
            if playing && time < duration {
                time += 1
            }
            if time >= duration {
                time = 0
            }
        }
        
    }
    
    
    func timeString(from seconds: Double) -> String {
            let minutes = Int(seconds) / 60
            let secs = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, secs)
        }
}

#Preview {
    MusicPlayerView()
}
