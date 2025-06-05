struct ForecastResponse: Codable {
    let location: LocationDTO
    let current: WeatherInfoDTO
    let forecast: ForecastDTO
}

struct ForecastDTO: Codable {
    let forecastday: [ForecastDayDTO]
}
