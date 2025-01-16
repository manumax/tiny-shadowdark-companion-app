// MARK: - Character

struct Character {
  let name: String
  let ancestry: String
  let `class`: String
  let level: Int

  static let empty = Character(
    name: "",
    ancestry: "",
    class: "",
    level: 0
  )
}

extension Character: Decodable {}

// MARK: - CharacterSheet

class CharacterSheet {
  private(set) var character: Character

  private(set) var armorClass = 10
  private(set) var initiative = 0
  private(set) var hitPoints: CappedValue = 0

  init(fromCharacter character: Character) {
    self.character = character
  }
}

extension CharacterSheet {
  var name: String {
    character.name
  }
  
  var hitPointsString: String {
    "\(hitPoints.current)/\(hitPoints.max)"
  }

  var descriptionString: String {
    "\(character.ancestry) \(character.class) \(character.level)"
  }
}

// MARK: - Preview Data

let characterSample = Character(
  name: "Myth",
  ancestry: "Human",
  class: "Fighter",
  level: 1
)

let characterSheetSample = CharacterSheet(
  fromCharacter: characterSample
)
