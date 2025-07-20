# Business Analytics-Integrated Financial Management System for IMVCMPC

## 📋 Project Overview

The **Business Analytics-Integrated Financial Management System Ibaan Market Vendors and Community Multi-Purpose Cooperative (IMVCMPC)** is a comprehensive Flutter-based mobile application designed to streamline financial operations across 12 cooperative branches. This system addresses the inefficiencies and inaccuracies in managing savings and disbursement reports by replacing manual processes with an automated, cloud-based solution.

### 🎯 Problem Statement
IMVCMPC faces challenges with:
- Manual processing delays across 12 branches
- Data inconsistencies in financial records
- Limited access to real-time financial insights
- Inefficient decision-making due to outdated reporting methods

### 🚀 Objectives
- **Automate Financial Management**: Streamline savings and disbursement tracking
- **Real-time Analytics**: Provide instant access to key financial metrics
- **AI-Driven Insights**: Implement prescriptive analytics for optimal resource allocation
- **Multi-User Access**: Enable secure access for Marketing Clerks, Finance Officers, and IT Heads

## ✨ Key Features

### 🔐 Authentication & Security
- Secure login/logout system
- Role-based access control
- User session management

### 👥 Member Management
- Create and manage member profiles
- Validate existing member information
- View individual member transaction histories
- Update member records and financial data

### 💰 Financial Operations
- **Savings Management**: Track member savings across all branches
- **Disbursement Tracking**: Monitor loan disbursements and repayments
- **Real-time Processing**: Instant transaction recording and validation
- **Branch Aggregation**: Consolidated financial data per branch

### 📊 Analytics & Reporting
- **Interactive Dashboards**: Real-time financial metrics visualization
- **AI Recommendations**: Prescriptive analytics for financial optimization
- **Custom Reports**: Exportable financial reports for selected periods
- **Multi-Criteria Decision Analysis (MCDA)**: Advanced analytics for resource allocation

### 📱 User Interface
- **Responsive Design**: Optimized for both desktop and mobile devices
- **Intuitive Navigation**: User-friendly interface with clear workflows
- **Data Visualization**: Charts, graphs, and interactive elements
- **Cross-Platform**: Works on Android, iOS, Web, and Desktop

## 🏗️ System Architecture

### Technology Stack
- **Frontend**: Flutter (Dart)
- **Backend**: None
- **Database**: None
- **Analytics**: AI-driven prescriptive analytics
- **Reporting**: PDF generation and export capabilities

### Project Structure
```
lib/
├── main.dart                 # Application entry point
├── app.dart                  # Main app configuration
├── member_data.dart          # Member data models
├── theme_colors.dart         # UI theme configuration
├── screens/                  # Main application screens
│   ├── login_screen.dart     # Authentication interface
│   ├── dashboard_screen.dart # Main dashboard
│   ├── analytics_screen.dart # Analytics and insights
│   ├── member_data_screen.dart # Member management
│   ├── reports_screen.dart   # Financial reporting
│   └── main_scaffold.dart    # Main app layout
└── widgets/                  # Reusable UI components
    ├── navigation_drawer.dart
    ├── chart_card.dart
    ├── member_form_dialog.dart
    ├── ai_recommendation_card.dart
    └── ... (other widgets)
```

## 🛠️ Installation & Setup

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio / VS Code
- Git

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone [repository-url]
   cd imvcmpc_flutter
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the Application**
   ```bash
   flutter run
   ```

### Building for Production

#### Android APK
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web --release
```

## 📱 Usage Guide

### User Roles & Permissions

#### Marketing Clerk (Main and Branches)
- **Member Management**: Create, update, and validate member profiles
- **Transaction Processing**: Input savings and disbursement records
- **Data Validation**: Ensure accuracy of financial data
- **Report Access**: View and export financial reports
- **Analytics Dashboard**: Access real-time financial metrics

### Key Workflows

#### 1. Member Registration
1. Navigate to Member Data screen
2. Click "Add New Member"
3. Fill in required member information
4. Validate and save member profile

#### 2. Financial Transaction Processing
1. Select member from database
2. Choose transaction type (savings/disbursement)
3. Enter transaction details
4. Validate and confirm transaction

#### 3. Report Generation
1. Access Reports screen
2. Select report type and date range
3. Choose target branches
4. Generate and export report

#### 4. Analytics Review
1. Navigate to Analytics screen
2. View real-time financial metrics
3. Review AI recommendations
4. Apply insights to decision-making

## 📞 Support

For technical support or questions about the system:
- **Email**: abionjanuelleasturias07@gmail.com
- **Phone**: 09913028095
- **Documentation**: canva.link

---

**Developed for Ibaan Market Vendors & Community Multi-Purpose Cooperative (IMVCMPC)**

*Empowering cooperative financial management through technology and analytics.*
