# Breakout

Petit clone de Breakout fait avec **Godot 4**, pour s'entraîner sur les bases du moteur : scènes, physique 2D, collisions, signaux.

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
- [ ] Briques
- [ ] Premier niveau
- [ ] Zone de mort + vies
- [ ] Score + HUD
- [ ] Victoire / défaite
- [ ] Briques à plusieurs PV, niveaux supplémentaires
- [ ] Power-ups
- [ ] Menu de sélection de niveau
- [ ] Sons, particules, screen shake

## Lancer le projet

Ouvrir le dossier dans Godot 4 et lancer avec **F5**.
