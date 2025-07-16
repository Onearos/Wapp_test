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

## 🗂 Architecture
```bash
lib/
│
├── core/               # Fonctionnalités transverses
│   ├── network/        # API Client
│   └── injection/      # DI (GetIt)
│
└── features/           # Module météo
    ├── data/           # Couche données
    │   ├── datasources # Sources (API + Cache)
    │   └── models      # DTOs
    │
    ├── domain/         # Métier pur
    │   ├── entities    # Modèles métier
    │   └── repositories# Contrats
    │
    └── presentation/   # UI
        ├── bloc/       # Gestion d'état
        └── pages/      # Écrans