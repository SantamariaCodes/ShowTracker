import SwiftUI

struct CustomGenrePicker: View {
    @Binding var selectedGenre: TvShowListTarget
    let genres: [TvShowListTarget]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(genres, id: \.self) { genre in
                    ZStack(alignment: .leading) {
                        if selectedGenre == genre {
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 2, height: 18)
                                .offset(x: -1) // Adjust the offset as needed
                        }
                        
                        Text(titleFor(genre))
                            .font(.system(size: 16, weight: selectedGenre == genre ? .bold : .regular))
                            .foregroundColor(selectedGenre == genre ? .primary : .secondary)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.clear)
                            .cornerRadius(8)
                            .onTapGesture {
                                selectedGenre = genre
                            }
                            .animation(nil, value: selectedGenre) // Disable implicit animation
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    CustomGenrePicker(selectedGenre: .constant(.popular), genres: [.popular, .airingToday, .onTheAir, .topRated])
}
func titleFor(_ listType: TvShowListTarget) -> String {
    switch listType {
    case .popular:
        return "Popular"
    case .airingToday:
        return "Airing Today"
    case .onTheAir:
        return "On The Air"
    case .topRated:
        return "Top Rated"
    case .details:
        return "Details"
    }
}
