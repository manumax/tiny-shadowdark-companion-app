import SwiftUI

struct CharacterPageView<Content>: View where Content: View {
  let characterSheet: CharacterSheet
  let content: () -> Content
  
  var body: some View {
    VStack {
      CharacterHeaderView(characterSheet: characterSheet)
        .frame(maxWidth: .infinity)
      content()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

// MARK: - Header

private struct CharacterHeaderView: View {
  let characterSheet: CharacterSheet

  var body: some View {
    VStack {
      CharacterSummaryView(characterSheet: characterSheet)
        .padding(8)
      HStack {
        StatView(title: "Armor Class", value: String(characterSheet.armorClass))
        StatView(title: "Initiative", value: String(characterSheet.initiative))
        StatView(title: "Hit Points", value: characterSheet.hitPointsString)
      }
    }
  }
}

struct CharacterSummaryView: View {
  let characterSheet: CharacterSheet
  @State var hasLuckyToken = false

  var body: some View {
    ZStack {
      Button {
        hasLuckyToken.toggle()
      } label: {
        VStack {
          Text(characterSheet.name)
            .font(.callout)
          
          Text(characterSheet.descriptionString)
            .font(.caption)
            .bold()
            .foregroundStyle(.secondary)
        }
      }
      .buttonStyle(.plain)
      .padding(12)
      .overlay {
        luckyTokenOverlay()
      }
    }
  }
  
  @ViewBuilder
  func luckyTokenOverlay() -> some View {
    if hasLuckyToken {
      RoundedRectangle(cornerRadius: 5.0)
        .stroke(.red, lineWidth: 2.0)
      
      ZStack {
        Circle()
          .frame(width: 30, height: 30)
          .foregroundStyle(.background)
        
        Image(systemName: "sun.horizon")
          .resizable()
          .scaledToFit()
          .frame(width: 20)
          .foregroundStyle(.red)
      }
      // TODO: This is some random number - we might use Geometry to get the right
      // value.
      .offset(y: -30)
    } else {
      RoundedRectangle(cornerRadius: 5.0)
        .stroke(.quinary, lineWidth: 2.0)
    }
  }
}

private struct StatView: View {
  let title: String
  let value: String

  var body: some View {
    VStack {
      Text(value)
        .font(.title3)
        .bold()
        .padding()
      Text(title.uppercased())
        .font(.footnote)
        .bold()
        .lineLimit(2)
        .multilineTextAlignment(.center)
    }
    .padding(8)
    .overlay {
      RoundedRectangle(cornerRadius: 5.0)
        .stroke(.primary, lineWidth: 2.0)
    }
  }
}

#Preview {
  let character = characterSample
  return CharacterPageView(characterSheet: characterSheetSample) {
    Text("Hello \(character.name)")
  }
}
