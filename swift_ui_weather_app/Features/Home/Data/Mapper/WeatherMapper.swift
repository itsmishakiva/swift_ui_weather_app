import Foundation
class WeatherMapper {
    func weatherInfoFromDTO(dto: WeatherInfoDTO) -> WeatherInfo {
        return WeatherInfo(
            id: UUID(),
            temperatureCelsium: Int(dto.tempC),
            windKm: Int(dto.windKph),
            feelsLikeCelsium: Int(dto.feelslikeC),
            humidity: dto.humidity,
            isDay: dto.isDay == 1,
        )
    }
    
    func hourlyWeatherInfoFromHourInfoDTO(dto: HourInfoDTO) -> HourlyWeatherInfo {
        let timeEpoch: Int = dto.timeEpoch
        let date = Date(timeIntervalSince1970: TimeInterval(timeEpoch))

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = .current

        let timeString = formatter.string(from: date)
        print("\(timeString) \(dto.isDay == 1)")
        
        return HourlyWeatherInfo(
            time: timeString,
            weatherInfo: WeatherInfo(
                id: UUID(),
                temperatureCelsium: Int(dto.tempC),
                windKm: Int(dto.windKph),
                feelsLikeCelsium: Int(dto.feelslikeC),
                humidity: dto.humidity,
                isDay: dto.isDay == 1,
            )
        )
    }
}
