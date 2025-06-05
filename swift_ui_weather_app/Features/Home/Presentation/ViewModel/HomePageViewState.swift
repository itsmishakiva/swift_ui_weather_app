extension HomePageView {
    struct HomePageViewState {
        let currentWeather : WeatherInfo
        let currentImageURL: String
        let location: Location
        let forecast: [HourlyWeatherInfo]?
        
        init(
            currentWeather: WeatherInfo,
            currentImageURL: String,
            location: Location,
            forecast: [HourlyWeatherInfo]? = nil
        ) {
            self.currentWeather = currentWeather
            self.currentImageURL = currentImageURL
            self.location = location
            self.forecast = forecast
        }
    }
}
