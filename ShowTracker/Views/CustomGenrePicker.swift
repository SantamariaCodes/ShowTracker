import SwiftUI

struct CustomGenrePicker: View {
    @Binding var selectedGenre: TvShowListTarget
    
    let genres: [TvShowListTarget] = [.popular, .airingToday, .onTheAir, .topRated]
    
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
                        
                        Text(genre.title)
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
    CustomGenrePicker(selectedGenre: .constant(.popular))
}
