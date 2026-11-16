# Breakout

Petit clone de Breakout fait avec **Godot 4**, pour s'entraîner sur les bases du moteur : scènes, physique 2D, collisions, signaux.

## Screenshots

<p align="center">
  <img src="docs/screenshots/gameplay.png" alt="Gameplay" width="480">
</p>

<table align="center">
  <tr>
    <td align="center"><img src="docs/screenshots/level.png" alt="Niveau" width="220"><br><sub>Niveau</sub></td>
    <td align="center"><img src="docs/screenshots/powerups.png" alt="Power-ups" width="220"><br><sub>Power-ups</sub></td>
    <td align="center"><img src="docs/screenshots/level_select.png" alt="Sélection de niveau" width="220"><br><sub>Sélection de niveau</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/skin_select.png" alt="Choix du skin" width="220"><br><sub>Choix du skin</sub></td>
    <td align="center"><img src="docs/screenshots/victory.png" alt="Victoire" width="220"><br><sub>Victoire</sub></td>
    <td align="center"><img src="docs/screenshots/game_over.png" alt="Défaite" width="220"><br><sub>Défaite</sub></td>
  </tr>
</table>

## Contrôles

| Action | Touche |
|---|---|
| Déplacer le paddle | ← / → |

## Structure

```
res://
├── main/          # scène racine : murs, paddle, balle, chargement des niveaux, UI
├── entities/
│   ├── paddle/
│   ├── ball/
│   ├── brick/
│   └── powerup/
├── levels/        # un niveau = une disposition de briques
├── ui/            # HUD, menus
└── shared/        # sprites, sons, polices
```

## Roadmap

- [x] Paddle
- [x] Murs
- [x] Balle (rebond selon la position sur le paddle)
- [X] Briques
- [X] Premier niveau
- [X] Zone de mort + vies
- [ ] Score + HUD
- [ ] Victoire / défaite
- [ ] Power-ups
- [ ] Menu de sélection de niveau/Niveaux supplémentaires
- [ ] Sons, particules, screen shake
- [ ] Check les private (fonctions, variables)
- [ ] Améliorer l'ui
- [ ] Commenter

## Lancer le projet

Ouvrir le dossier dans Godot 4 et lancer avec **F5**.
