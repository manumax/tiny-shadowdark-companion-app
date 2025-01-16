import SwiftUI

struct CharacterView: View {
  var characterSheet: CharacterSheet
  
  var body: some View {
    CharacterPageView(characterSheet: characterSheet) {
      Text("Test")
    }
    .navigationBarHidden(true)
  }
}

#Preview {
  CharacterView(
    characterSheet: characterSheetSample
  )
}
