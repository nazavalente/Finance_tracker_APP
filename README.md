# Finance Tracker Mobile Application

Finance Tracker Mobile Application is a full-stack mobile application designed to help users record, manage, and monitor personal financial transactions. The application provides features for tracking income and expenses, viewing balance summaries, filtering transaction data, and reviewing expense reports by category. This project was developed using a separated frontend and backend architecture.

## Project Overview

The main purpose of this project is to provide a simple and structured finance tracking system for daily personal money management. Users can add income and expense records, organize transactions by category, and view financial summaries from a mobile interface.

The system is divided into two main parts:

- **Frontend**: Flutter mobile application for user interaction.
- **Backend**: RESTful API built with Node.js and Express.js for transaction data management.

## Features

The application includes the following main features:

- Add income and expense transactions
- Edit existing transaction data
- Delete transaction records
- View transaction list
- Search transactions by title, category, or note
- Filter transactions by all, income, or expense
- View total income, total expense, and current balance
- View financial report summary
- View expense breakdown by category
- Indonesian currency and date formatting
- Firestore-based transaction storage

## Tech Stack

### Frontend

- Flutter
- Dart
- Provider
- HTTP
- Intl
- Material Design

### Backend

- Node.js
- Express.js
- Firebase Admin SDK
- Cloud Firestore
- CORS
- dotenv
- nodemon

### Database

- Firebase Cloud Firestore

## Project Structure

```text
finance_tracker_mobile_app/
|
├── backend/
|   ├── config/
|   |   └── db.js
|   ├── controllers/
|   |   └── transactionController.js
|   ├── models/
|   |   └── transactionModel.js
|   ├── routes/
|   |   └── transactionRoutes.js
|   ├── scripts/
|   |   └── migrate-sqlite-to-firestore.js
|   ├── .env.example
|   ├── package.json
|   ├── package-lock.json
|   └── server.js
|
├── frontend/
|   ├── lib/
|   |   ├── app/
|   |   ├── core/
|   |   ├── models/
|   |   ├── pages/
|   |   ├── providers/
|   |   ├── repositories/
|   |   ├── services/
|   |   ├── shared/
|   |   └── main.dart
|   ├── android/
|   ├── ios/
|   ├── web/
|   ├── pubspec.yaml
|   └── pubspec.lock
|
├── .gitignore
└── README.md
```

## Data Model

The main data model used in this project is **Transaction**.

Transaction fields include:

- **id**: unique transaction identifier
- **title**: transaction name or description
- **amount**: transaction amount
- **type**: transaction type, either `income` or `expense`
- **category**: transaction category
- **note**: optional transaction note
- **date**: transaction date

## API Overview

The backend provides REST API routes for transaction management.

```text
GET    /api/transactions
POST   /api/transactions
PUT    /api/transactions/:id
DELETE /api/transactions/:id
```

The backend also provides a root endpoint:

```text
GET /
```

This endpoint returns a message indicating that the Finance Tracker API is running.

## Getting Started

Follow these steps to run the project locally.

### Prerequisites

Make sure you have installed:

- Flutter SDK
- Dart SDK
- Node.js
- npm
- Git
- Firebase project with Firestore enabled
- Android Studio or an Android emulator

## Backend Setup

1. Open the backend folder:

```bash
cd backend
```

2. Install backend dependencies:

```bash
npm install
```

3. Create a `.env` file based on `.env.example`:

```env
GOOGLE_APPLICATION_CREDENTIALS=C:\absolute\path\to\your-firebase-adminsdk.json
```

4. Start the backend server:

```bash
npm run dev
```

The backend will run on:

```text
http://localhost:8000
```

For Android emulator access, the Flutter app uses:

```text
http://10.0.2.2:8000/api
```

## Frontend Setup

1. Open the frontend folder:

```bash
cd frontend
```

2. Install Flutter dependencies:

```bash
flutter pub get
```

3. Run the Flutter application:

```bash
flutter run
```

## Environment Variables

### Backend `.env`

```env
GOOGLE_APPLICATION_CREDENTIALS=C:\absolute\path\to\your-firebase-adminsdk.json
```

Do not upload the real `.env` file or Firebase service account JSON file to GitHub. Use `.env.example` to show the required environment variable.

## Available Scripts

### Backend

```bash
npm run dev
```

Runs the backend server using nodemon.

```bash
npm start
```

Runs the backend server using Node.js.

```bash
npm run migrate:sqlite
```

Runs the migration script for moving SQLite data to Firestore.

### Frontend

```bash
flutter pub get
```

Installs Flutter dependencies.

```bash
flutter run
```

Runs the mobile application.

```bash
flutter analyze
```

Analyzes the Flutter source code.

## My Contribution

In this project, I worked on building a finance tracker mobile application with a separated frontend and backend structure. My work involved developing transaction management features, connecting the Flutter application to a REST API, organizing backend routes and controllers, integrating Firestore as the database, and preparing the project structure for submission.

## What I Learned

Through this project, I strengthened my understanding of:

- Mobile application development using Flutter
- State management using Provider
- REST API integration in a mobile application
- Backend development using Node.js and Express.js
- Firebase Admin SDK and Firestore integration
- CRUD operations for transaction data
- Project organization with separated frontend and backend folders
- Environment variable usage for sensitive credentials

## Future Improvements

Several improvements can be made in future development, including:

- Adding user authentication
- Adding monthly and yearly financial reports
- Adding charts for income and expense visualization
- Adding budget planning features
- Adding recurring transaction support
- Adding export features for transaction history
- Improving form validation and error handling
- Adding unit and integration testing
- Preparing production deployment configuration

## Author

Nazario Jose Valente da Cruz  
Informatics Student  
Telkom University

## Repository

This repository contains the Flutter frontend, Express backend, Firestore integration, and project configuration for the Finance Tracker Mobile Application.
