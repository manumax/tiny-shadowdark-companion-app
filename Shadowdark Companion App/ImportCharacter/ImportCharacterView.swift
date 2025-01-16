import SwiftUI

struct ImportCharacterView: View {
  @State private var jsonToImport = ""
  @State private var hasCharacterBeingImported = false
  @State private var characterSheet = CharacterSheet(fromCharacter: .empty)
    
  var body: some View {
    NavigationStack {
    if hasCharacterBeingImported {
      CharacterView(characterSheet: characterSheet)
    } else {
        VStack {
          Text("Copy and paste json from Shadowdarkling to import the character:")
            .font(.callout)
          
          TextEditor(text: $jsonToImport)
            .overlay {
              RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2.0)
                .foregroundStyle(.quinary)
            }
          
          Button {
            Task {
              importingCharacter()
            }
          } label: {
            Text("Import Character")
          }
          .disabled(jsonToImport.isEmpty)
          .buttonStyle(.borderedProminent)
        
        }
        .padding(.all, 16.0)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Import Character")
      }
    }
  }
  
  private func importingCharacter() {
    let jsonData = jsonToImport.data(using: .utf8)!
    let character = try! JSONDecoder().decode(Character.self, from: jsonData)
    characterSheet = CharacterSheet(fromCharacter: character)
    hasCharacterBeingImported = true
  }
}

#Preview {
  ImportCharacterView()
}
