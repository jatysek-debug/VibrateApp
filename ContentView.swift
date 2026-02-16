import SwiftUI
import AudioToolbox

struct ContentView: View {
    @State private var holding = false
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            Circle()
                .fill(Color.green)
                .frame(width: 170, height: 170)
                .overlay(
                    Text("HOLD")
                        .foregroundColor(.black)
                        .font(.system(size: 28, weight: .bold))
                )
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !holding {
                                holding = true
                                startVibration()
                            }
                        }
                        .onEnded { _ in
                            holding = false
                            stopVibration()
                        }
                )
        }
    }

    func startVibration() {
        stopVibration()
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        timer = Timer.scheduledTimer(withTimeInterval: 0.35, repeats: true) { _ in
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }

    func stopVibration() {
        timer?.invalidate()
        timer = nil
    }
}
