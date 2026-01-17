# Campedia - Camping Equipment Rental Platform

Campedia is a mobile application designed for renting camping equipment and gear. It provides a seamless experience for outdoor enthusiasts to browse, rent, and manage camping gear, making outdoor adventures more accessible.

This project is built using a Client-Server architecture with a **Flutter** frontend and a **FastAPI** backend.

## 📱 Project Description

Campedia allows users to:
- **Browse Catalog**: View available camping gear, categories, and recommended items.
- **Rent Equipment**: Add items to a cart, proceed to checkout, and manage rentals.
- **Manage Account**: User authentication (Sign In/Sign Up), profile management, and transaction history.
- **Features**: Wishlist, Notifications, Order Tracking, and more.

## 🏗️ System Design

The system follows a separated frontend-backend architecture:

### Frontend (Mobile App)
- **Framework**: Flutter
- **State Management**: Provider
- **Structure**:
  - `pages/`: UI Screens (Home, Detail, Cart, Profile, etc.)
  - `providers/`: State management logic for logic separation.
  - `services/`: API communication layer.
  - `models/`: Data models matching API responses.

### Backend (API)
- **Framework**: FastAPI (Python)
- **Database**: SQL (MySQL)
- **Structure**:
  - `routes/`: API endpoints (Barang, Cart, Transaction, User, etc.)
  - `services/`: Business logic.
  - `models/`: Database schemas (Pydantic/SQLAlchemy).
  - `config/`: Database configuration.
  - `static/`: Serves static assets like product images.

## 🛠️ Tech Stack

- **Mobile App**: Flutter (Dart)
- **Backend API**: FastAPI (Python)
- **Database**: MySQL
- **Assets**: Local assets & Static file serving

## 🚀 How to Run

### Prerequisites
- Python 3.x installed.
- Flutter SDK installed.
- MySQL Database running.

### 1. Database Setup
1.  Import the SQL dump file located in `campedia/database/db_provis_2.sql` (or `campedia-fastapi/Database/db_provis.sql`) into your MySQL database.
2.  Configure the database connection in `campedia-fastapi/config/database.py` to match your local MySQL credentials.

### 2. Backend Setup (FastAPI)
Navigate to the backend directory:
```bash
cd campedia-fastapi
```

Install dependencies:
```bash
pip install -r requirements.txt
```

Run the server:
```bash
# Using uvicorn
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```
The API will be available at `http://localhost:8000` (or your machine's IP).

### 3. Frontend Setup (Flutter)
Navigate to the frontend directory:
```bash
cd campedia
```

**Important**: Check the API Configuration
Open `lib/services/api_config.dart` (or similar config file) and ensure the `baseUrl` points to your running FastAPI server (e.g., `http://10.0.2.2:8000` for Android Emulator or your LAN IP for physical devices).

Install dependencies:
```bash
flutter pub get
```

Run the application:
```bash
flutter run
```

## 📂 Project Structure

```
campedia-project/
├── campedia-fastapi/      # Python FastAPI Backend
│   ├── main.py            # Entry point
│   ├── routes/            # API Endpoints
│   ├── config/            # DB Config
│   └── ...
└── campedia/              # Flutter Mobile App
    ├── lib/               # Dart code
    ├── pubspec.yaml       # Dependencies
    └── ...
```
