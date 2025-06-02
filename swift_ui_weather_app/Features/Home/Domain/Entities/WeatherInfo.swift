import Foundation

struct WeatherInfo: Identifiable {
    let id: UUID
    let temperatureCelsium: Int
    let windKm: Int
    let feelsLikeCelsium: Int
    let humidity: Int
}
