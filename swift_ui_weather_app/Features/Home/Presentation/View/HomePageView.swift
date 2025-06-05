import SwiftUI

struct HomePageView: View {
    static let screenSize = UIScreen.main.bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
    
    @StateObject private var viewModel = HomePageViewModel(
        repository: DefaultWeatherRepository(
            apiClient: DefaultWeatherApiClient(),
            mapper: WeatherMapper()
        )
    )
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .error(let error):
                Text(error.localizedDescription)
            case .data(let data):
                var currentImageURL: String {
                    data.currentImageURL
                }
                var currentWeather: WeatherInfo {
                    data.currentWeather
                }
                var location: Location {
                    data.location
                }
                var forecast: [HourlyWeatherInfo]? {
                    data.forecast
                }
                
                
                AsyncImage(url: URL(string: currentImageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                } placeholder: {
                    Color.blue.ignoresSafeArea()
                }
                VStack {
                    Spacer().frame(height: 60)
                    Text(
                        location.title,
                    ).font(.headline)
                        .foregroundColor(.white)
                    Spacer().frame(height: 8)
                    Text(
                        String(format: "%d°C", currentWeather.temperatureCelsium)
                    ).font(.headlineHuge)
                        .foregroundColor(.white)
                    Spacer().frame(height: 48)
                    HStack(alignment: .top){
                        VStack{
                            Text(
                                String(format: "Wind: %d km/h", currentWeather.windKm)
                            ).font(.caption)
                                .foregroundColor(.white)
                            Spacer().frame(height: 8)
                            Text(
                                String(format: "Feels like: %d °C", currentWeather.feelsLikeCelsium)
                            ).font(.caption)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        VStack{
                            Text(
                                
                                String(format: "Humidity: %d", currentWeather.humidity)
                            ).font(.caption)
                                .foregroundColor(.white)
                        }
                    }.padding(.horizontal, 48)
                    Spacer()
                    if forecast != nil {
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 16) {
                                Spacer().frame(width: 0)
                                ForEach(forecast!) { weather in
                                    WeatherTile(weather: weather)
                                }
                                Spacer().frame(width: 0)
                            }
                        }
                    }
                    Spacer().frame(height: 60)
                }.frame(width: HomePageView.screenWidth)
            }
        }.onAppear {
            Task {
                await viewModel.getCurrentWeather()
            }
        }
    }
}

#Preview {
    HomePageView()
}
