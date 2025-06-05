protocol WeatherRepository {
    func getCurrentWeather(location: Location) async throws -> WeatherInfo
    
    func getWeatherForDay(location: Location) async throws -> [HourlyWeatherInfo]
}
