# Travel Guide

Travel Guide is a mobile companion for restless explorers who want curated itineraries, local eats, and actionable travel insights in one place. The app helps travelers go from “Where should I start?” to a confident trip plan in minutes.

## Why It Matters
- **Reduce planning fatigue:** Replace endless tab-hopping with a single experience tailored to a traveler’s “home base” and interests.
- **Drive conversion-ready intent:** Surface themed itineraries, food tours, and seasonal events that can be packaged into bookable experiences.
- **Increase retention:** Keep explorers returning with fresh guides, saved plans, and a personal timeline builder that evolves with every trip.

- **Personalized Home** – Dynamic hero banner, city context grid, quick feature tiles, and mock “plan ahead” cards that react to a traveler’s home base.
- **Curated Explore Feed** – Reusable welcome banner components introduce themed collections, followed by scannable cards and destination highlights.
- **Plan Timeline** – Interactive timeline with add/edit/detail flows so travelers can assemble a day-by-day plan and tweak it on the fly.
- **Quick Planner FAB** – Full-height bottom sheet with templates, preference chips, and description capture for instant itinerary drafts.
- **Onboarding & Preferences** – Riverpod-backed location selector, explicit travel preferences, localization preview, and guest vs. signed-in profile states.
- **Reusable UI Kit** – Shared widgets (`WelcomeBanner`, `CityContextGrid`, `ProfileHeader`, etc.) ensure consistent experiences across home, explore, favorites, and profile screens.

## Target Personas
| Persona | Need | How Travel Guide Helps |
| --- | --- | --- |
| Weekend Wanderer | Fast, themed escapes | Ready-made itineraries with timeline quick-add |
| Food Explorer | Neighborhood gems | Local eats feature list & insight cards |
| Planner Extraordinaire | Structured trips | Timeline editor, saved plans, and tips hub |

## Getting Started
> Prerequisites: Flutter 3.16+, Dart 3, and Xcode/Android Studio for platform tooling.

```bash
flutter pub get           # Install dependencies
flutter run               # Launch the app on an attached device/emulator
flutter analyze           # Static analysis
flutter test              # Unit/widget tests (when available)

dart run build_runner build --delete-conflicting-outputs
```

## Measuring Success
- **Activation:** % of new users who set a home location and interact with at least one feature tile.
- **Engagement:** Average number of timeline entries created per active user.
- **Retention:** 7-day return rate driven by saved plans and seasonal festival content.

## Additional Documentation
- [Technical Architecture](docs/technical.md)
- Product feedback & requests: `product@travelguide.app`

---
_Travel Guide is currently in concept validation. All data is mock content intended to demonstrate UX and systems design._ 
