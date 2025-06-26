import Foundation
class DefaultWeatherRepository: WeatherRepository {
    private let apiClient: WeatherApiClient
    private let mapper: WeatherMapper
    
    init(apiClient: WeatherApiClient, mapper: WeatherMapper) {
        self.apiClient = apiClient
        self.mapper = mapper
    }
    
    func getCurrentWeather(location: Location) async throws -> WeatherInfo {
        let dto = try await apiClient.getCurrentWeather(location: location)
        return mapper.weatherInfoFromDTO(dto: dto.current)
    }
    
    func getWeatherForDay(location: Location) async throws -> [HourlyWeatherInfo] {
        var hoursInfo = (try await apiClient.getWeatherForDay(location: location)).forecast.forecastday.first?.hour ?? []
        hoursInfo.removeAll{$0.timeEpoch < Int(Date().timeIntervalSince1970)}
        let hourlyWeather = hoursInfo.map {mapper.hourlyWeatherInfoFromHourInfoDTO(dto: $0)}
        return hourlyWeather
    }
}
