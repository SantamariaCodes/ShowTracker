import SwiftUI

struct CustomGenrePicker: View {
    @Binding var selectedGenre: TvShowListTarget?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                // Add "All" as the first option
                ZStack(alignment: .leading) {
                    if selectedGenre == nil {
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 2, height: 18)
                            .offset(x: -1)
                    }
                    
                    Text("All")
                        .font(.system(size: 16, weight: selectedGenre == nil ? .bold : .regular))
                        .foregroundColor(selectedGenre == nil ? .primary : .secondary)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.clear)
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedGenre = nil // Set selectedGenre to nil for "All"
                        }
                        .animation(nil, value: selectedGenre)
                }
                
                // Display the existing genres
                ForEach(TvShowListTarget.allCases, id: \.self) { genre in
                    ZStack(alignment: .leading) {
                        if selectedGenre == genre {
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 2, height: 18)
                                .offset(x: -1)
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
                            .animation(nil, value: selectedGenre)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    CustomGenrePicker(selectedGenre: .constant(nil))
}
