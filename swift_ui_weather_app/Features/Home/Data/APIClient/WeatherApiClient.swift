protocol WeatherApiClient {
    func getCurrentWeather(location: Location) async throws -> WeatherResponse
    
    func getWeatherForDay(location: Location) async throws -> ForecastResponse
}
