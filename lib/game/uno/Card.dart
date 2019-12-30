abstract class Card {
  bool canPlaceCard(Card card);

  Card(Card lastCard);
}

class CardManager {
  var registerBlacks;

  CardManager(this.registerBlacks) {}
}
