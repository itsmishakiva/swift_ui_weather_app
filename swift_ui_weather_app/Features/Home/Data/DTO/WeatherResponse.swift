import Foundation

struct WeatherResponse: Codable {
    let location: LocationDTO
    let current: WeatherInfoDTO
}
