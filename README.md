# Smart Ride Booking & Trip Management App

## Overview
A Flutter application simulating a real-time ride booking platform
with live trip updates, offline storage, and dashboard analytics.

## Tech Stack
- Flutter 3.x
- Riverpod (StateNotifier)
- Hive (Local Storage)

## Architecture
- UI Layer
- State Management Layer
- Repository Layer
- Local Persistence

## Real-Time Simulation
Ride status progression is simulated using async state transitions
inside Riverpod StateNotifiers.

## Features
- Trip booking & management
- Live ride status updates
- Real-time dashboard analytics
- Offline support with Hive
- In-app notifications

## Testing
Includes basic unit and widget tests covering:
- Trip logic
- UI rendering

## How to Run
```bash
flutter pub get
flutter run
