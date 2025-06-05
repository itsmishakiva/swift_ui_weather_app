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
        let dto = try await apiClient.getWeatherForDay(location: location)
        return dto.forecast.forecastday.first?.hour.map {mapper.hourlyWeatherInfoFromHourInfoDTO(dto: $0)} ?? []
    }
}
