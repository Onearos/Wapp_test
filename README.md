# Weather App Test - Projet Technique

## 📝 Description  
Application mobile de prévision météo développée avec Flutter, utilisant :  
- **BLoC** pour la gestion d'état  
- **Mockoon** pour simuler l'API  
- **Hive** pour le cache offline  

## 🚀 Fonctionnalités  
✔️ Affichage des prévisions horaires (24h)  
✔️ Mode hors ligne avec stockage local  
✔️ Interface utilisateur moderne (effets "glassy")  
✔️ Pull-to-refresh pour actualiser les données  

## 🛠 Configuration  
1. **Lancer Mockoon** :  
   - Importer le fichier `weather_mockoon.json`  
   - Démarrer le serveur sur `localhost:3000`  

2. **Lancer l'application** :  
   ```bash
   flutter pub get
   flutter run

## ⚠️ Notes techniques
Les tests unitaires n'ont pas été implémentés par manque de temps
L'application affiche les données même sans connexion

## Structure overview

lib/
├── core/          # Code transverse (network, injection)
├── features/      # Fonctionnalités météo
│   ├── data       # Sources de données
│   ├── domain     # Métier et entités
│   └── presentation # UI et BLoC

