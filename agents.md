# Agents Reference for FurniShop

## Purpose
This document defines rules, architecture, and coding standards for AI agents contributing to the FurniShop project.

## Project Overview
- Flutter mobile app for furniture e-commerce
- Clean Architecture: core + features
- Features: chairs (reference), desks, bedrooms, living_rooms, etc.

## Folder Structure
- `lib/core/` → reusable widgets, theme, errors, navigation
- `lib/features/<feature>/`
  - `data/` → models, datasources, repository implementations
  - `domain/` → entities, use cases, repository interfaces
  - `presentation/` → pages, providers, state, widgets

## Coding Guidelines
- Use Riverpod StateNotifier for state management
- Reuse core widgets (`AppScaffold`, `AppText`, `ProductCard`, `AppButton`)
- Follow naming conventions:
  - Feature folders: lowercase singular
  - Classes: PascalCase
  - Files: snake_case
- Register routes in `core/navigation/routes.dart`

## Feature Contract
- Every feature must implement:
  - Mock or real data in data layer
  - Use case(s) in domain
  - Page with loading, empty, error states in presentation
  - Unit and widget tests

## Agent Instructions
- When generating a new feature:
  - Follow the Chairs feature as reference
  - Do not create custom widgets if a core widget exists
  - Maintain folder and file structure
  - Follow state management and UI patterns exactly

## Testing
- Include unit tests for domain and repository
- Include widget tests for all pages
