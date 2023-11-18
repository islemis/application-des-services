import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Indice de l'onglet actuel

  final List<Widget> _pages = [
    // Ajoutez d'autres pages ici si nécessaire
    // Par exemple, vous pouvez ajouter une autre page comme HomePageContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'), // Affiche le titre de la page actuelle
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Couleur du cadre
                  width: 1.0, // Épaisseur du cadre
                ),
                borderRadius: BorderRadius.circular(8.0), // Rayon des bords du cadre
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Rechercher...',
                    icon: Icon(Icons.search),
                    border: InputBorder.none, // Supprime la bordure par défaut du TextField
                  ),
                  onChanged: (query) {
                    // Ajoutez ici la logique de recherche en temps réel
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _pages.isEmpty
                ? Center(
              child: Text('Contenu de la page d\'accueil'),
            )
                : _pages[_currentIndex], // Affiche la page correspondant à l'onglet actuel
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Met à jour l'indice de l'onglet actuel lorsqu'il est tapé
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
