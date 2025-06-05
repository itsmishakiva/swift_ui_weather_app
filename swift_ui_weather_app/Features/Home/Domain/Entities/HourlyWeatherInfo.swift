import Foundation
struct HourlyWeatherInfo : Identifiable {
    let id: UUID = UUID()
    let time : String
    let weatherInfo : WeatherInfo
}
