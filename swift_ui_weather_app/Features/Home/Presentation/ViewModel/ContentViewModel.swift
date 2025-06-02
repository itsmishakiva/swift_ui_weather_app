import Foundation

extension HomePageView {
    class ContentViewModel: ObservableObject {
        @Published var state = ViewState<ContentViewState>.loading
        
        func getData() async {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            
            let weatherInfo = WeatherInfo(
                id: UUID(),
                temperatureCelsium: 15,
                windKm: 10,
                feelsLikeCelsium: 18,
                humidity: 60
            )
            
            let location = Location(id: UUID(), title: "London")
            
            let imageUrl = "https://www.thecalifornian.com/gcdn/-mm-/e5c305e00d80354d1c0350948b3ccc39c5d4956e/c=0-202-3867-2377/local/-/media/Salinas/2015/03/19/B9316661963Z.1_20150319105958_000_GLQA8VSAM.1-0.jpg"
            
            await MainActor.run {
                self.state = .data(
                    ContentViewState(
                        currentWeather: weatherInfo,
                        currentImageURL: imageUrl,
                        location: location
                    )
                )
            }
            
        }
    }
}
