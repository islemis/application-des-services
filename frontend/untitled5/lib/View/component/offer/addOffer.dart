import 'package:flutter/material.dart';
import 'package:untitled5/Services/Offer/OfferService.dart';

class addOffer extends StatelessWidget {
  final TextEditingController nomServiceController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController prixController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.miscellaneous_services, // Replace with the desired service icon
              color: Colors.green[400]!, // Utilisation de vert
              size: 24.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Ajout De Service',
              style: TextStyle(
                color: Colors.green[400]!, // Utilisation de vert
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue[100]!, // Utilisation de bleu
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nom du service
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nom Service',
              ),
            ),
            SizedBox(height: 16.0),

            // Adresse
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Adresse',
              ),
            ),
            SizedBox(height: 16.0),

            // Prix
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Prix',
              ),
            ),
            SizedBox(height: 16.0),

            // Description du service
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description du Service',
              ),
            ),
            SizedBox(height: 16.0),

            // Détails du service
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Détails du Service',
              ),
            ),
            SizedBox(height: 16.0),

            // Emplacement pour télécharger une image
            Container(
              height: 200.0, // Ajustez la hauteur selon vos besoins
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'Espace pour l\'upload d\'image',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            /* Bouton pour soumettre le formulaire
            ElevatedButton(
              onPressed: () async{
                await addOffre( nomServiceController.text,
                  adresseController.text,
                  prixController.text,
                  descriptionController.text,
                  detailsController.text);
                // Ajouter la logique pour soumettre le formulaire d'ajout de service
              },
              child: Text('Ajouter le Service'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green[100]!, // Utilisation de vert
              ),
            ) ,*/
          ],
        ),
      ),
    );
  }
}

