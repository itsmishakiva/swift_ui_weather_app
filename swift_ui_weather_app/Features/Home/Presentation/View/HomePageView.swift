import SwiftUI

struct HomePageView: View {
    static let screenSize = UIScreen.main.bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
    
    @StateObject private var viewModel = ContentViewModel()
    
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
                    ).font(
                        .system(size: 32, weight: .regular, design: .rounded)
                    ).foregroundColor(.white)
                    Spacer().frame(height: 8)
                    Text(
                        String(format: "%d°C", currentWeather.temperatureCelsium)
                    ).font(
                        .system(size: 70, weight: .bold, design: .default)
                    ).foregroundColor(.white)
                    Spacer().frame(height: 48)
                    HStack(alignment: .top){
                        VStack{
                            Text(
                                String(format: "Wind: %d km/h", currentWeather.windKm)
                            ).font(
                                .system(size: 20, weight: .regular, design: .default)
                            ).foregroundColor(.white)
                            Spacer().frame(height: 8)
                            Text(
                                String(format: "Feels like: %d °C", currentWeather.feelsLikeCelsium)
                            ).font(
                                .system(size: 20, weight: .regular, design: .default)
                            ).foregroundColor(.white)
                        }
                        Spacer()
                        VStack{
                            Text(
                                
                                String(format: "Humidity: %d", currentWeather.humidity)
                            ).font(
                                .system(size: 20, weight: .regular, design: .default)
                            ).foregroundColor(.white)
                        }
                    }.padding(.horizontal, 48)
                        .frame(width: HomePageView.screenWidth)
                    Spacer()
                    ScrollView(Axis.Set.horizontal, showsIndicators: false){
                        HStack(spacing: 16) {
                            Spacer().frame(width: 0)
                            ForEach(0..<7, id: \.self) { index in
                                WeatherTile(currentWeather: currentWeather)
                            }
                            Spacer().frame(width: 0)
                        }
                    }.frame(width: HomePageView.screenWidth)
                    Spacer().frame(height: 60)
                }
            }
        }.onAppear {
            Task {
                await viewModel.getData()
            }
        }
    }
}

#Preview {
    HomePageView()
}
