import SwiftUICore

extension HomePageView {
    struct WeatherTile : View {
        let weather:HourlyWeatherInfo
        
        init(weather: HourlyWeatherInfo) {
            self.weather = weather
            print("\(weather.time) \(weather.weatherInfo.isDay)")
        }
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                Gradient.Stop(color: Color.white.opacity(0.4), location: 0),
                                Gradient.Stop(color: Color.white.opacity(0), location: 1)
                            ]),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading,
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.1))
                            .stroke(Color.white.opacity(0.4), lineWidth: 1)
                            .blur(radius: 1)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        
                    )
                    .padding(.vertical, 24)
                    .shadow(radius: 10)
                VStack {
                    Text(
                        weather.time
                    ).font(
                        .caption
                    ).foregroundColor(.white)
                    Text(
                        "\(weather.weatherInfo.temperatureCelsium) °C"
                    ).font(
                        .captionBold
                    ).foregroundColor(.white)
                    Image(systemName: weather.weatherInfo.isDay ? "sun.max.fill" : "moon.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                }.padding(.all, 16)
            }.frame(width: 120, height: 190)
        }
    }
}
