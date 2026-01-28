# Agents Reference for FurniShop

## Purpose
This document defines rules, architecture, and coding standards for AI agents contributing to the FurniShop project.

## Project Overview
- Flutter mobile app for furniture e-commerce
- Features: chairs, desks, bedrooms, living_rooms, etc.

## Coding Guidelines
- Reuse core widgets (`AppScaffold`, `AppText`, `ProductCard`, `AppButton`)
- Register routes in `core/navigation/routes.dart`

## Feature Contract
- Every feature must implement:
  - Mock or real data in data layer
  - Use case(s) in domain
  - Page with loading, empty, error states in presentation
  - Unit and widget tests

## Agent Instructions
- When generating a new feature:
  - Follow the same architecture and patterns used
  - Do not create custom widgets if a core widget exists
  - Maintain folder and file structure
  - Follow state management and UI patterns exactly
