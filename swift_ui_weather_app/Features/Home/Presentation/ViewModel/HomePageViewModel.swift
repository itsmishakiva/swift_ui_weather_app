import Foundation

extension HomePageView {
    class HomePageViewModel: ObservableObject {
        private let repository: WeatherRepository
        @Published var state : ViewState<HomePageViewState>
        
        init(
            repository: WeatherRepository,
            state: ViewState<HomePageViewState> = ViewState<HomePageViewState>.loading
        ) {
            self.repository = repository
            self.state = state
        }
        
        func getForecast() async {
            if case .data(let currentState) = state {
                do {
                    let forecast = try await repository.getWeatherForDay(location: currentState.location)
                    await MainActor.run {
                        self.state = .data(
                            HomePageViewState(
                                currentWeather: currentState.currentWeather,
                                currentImageURL: currentState.currentImageURL,
                                location: currentState.location,
                                forecast: forecast
                            )
                        )
                    }
                } catch {
                    await MainActor.run {
                        self.state = .error(error)
                    }
                }
            }
        }
        
        func getCurrentWeather() async {
            let location = Location(id: UUID(), title: "Saint-Petersburg")
            let imageUrl = "https://www.thecalifornian.com/gcdn/-mm-/e5c305e00d80354d1c0350948b3ccc39c5d4956e/c=0-202-3867-2377/local/-/media/Salinas/2015/03/19/B9316661963Z.1_20150319105958_000_GLQA8VSAM.1-0.jpg"
            
            do {
                let weatherInfo =
                try await repository.getCurrentWeather(location: location)
                await MainActor.run {
                    self.state = .data(
                        HomePageViewState(
                            currentWeather: weatherInfo,
                            currentImageURL: imageUrl,
                            location: location
                        )
                    )
                }
                await getForecast()
            } catch {
                await MainActor.run {
                    self.state = .error(error)
                }
            }
        }
    }
}
