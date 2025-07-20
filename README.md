# <span style="color: #1a621d;">Business Analytics-Integrated Financial Management System for IMVCMPC</span>

## 📋 Project Overview

The **<span style="color: #1a621d;">Business Analytics-Integrated Financial Management System Ibaan Market Vendors and Community Multi-Purpose Cooperative (IMVCMPC)</span>** is a comprehensive Flutter-based mobile application designed to streamline financial operations across 12 cooperative branches. This system addresses the inefficiencies and inaccuracies in managing savings and disbursement reports by replacing manual processes with an automated, cloud-based solution.

### <span style="color: #94c14d;">⚠️ Problem Statement</span>
IMVCMPC faces challenges with:
- <span style="color: #a4d586;">Manual processing delays across 12 branches</span>
- <span style="color: #a4d586;">Data inconsistencies in financial records</span>
- <span style="color: #a4d586;">Limited access to real-time financial insights</span>
- <span style="color: #a4d586;">Inefficient decision-making due to outdated reporting methods</span>

### <span style="color: #94c14d;">📚 Objectives of the Study</span>

#### <span style="color: #1a621d;">🎯 Main Objective</span>
<span style="color: #a4d586;">To design and develop a cloud-based system with a web-based interface, specifically tailored to the needs of the Ibaan Market Vendors & Community Multi-Purpose Cooperative, or IMVCMPC.</span>

#### <span style="color: #94c14d;">📋 Specific Objectives</span>

**<span style="color: #1a621d;">📌 Specific Objective 1:</span>**
<span style="color: #a4d586;">To develop a system accessible by the Marketing Clerk.</span>

**<span style="color: #1a621d;">📌 Specific Objective 2:</span>**
<span style="color: #a4d586;">To generate automated financial reports based on real-time monitoring and processing of savings and disbursements.</span>

**<span style="color: #1a621d;">📌 Specific Objective 3:</span>**
<span style="color: #a4d586;">To incorporate AI-driven prescriptive analytics using Multi-Criteria Decision Analysis (MCDA).</span>

## ✨ Key Features

### 🔐 Authentication & Security
- Secure login/logout system
- Role-based access control

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
- **Cross-Platform**: Works on Android, Web, and Desktop

## 🏗️ System Architecture

### Technology Stack
- **Frontend**: Flutter (Dart)
- **Backend**: None (Frontend-only application)
- **Database**: Hardcoded data (No external database)
- **Data Storage**: In-memory data structures (List<Map<String, dynamic>>)
- **Authentication**: Mock authentication system
- **Analytics**: AI-driven prescriptive analytics (simulated)
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
- Flutter SDK (version 3.8.1)
- Dart SDK
- VS Code
- Git

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/asturias-jnll/imvcmpc_flutter_app.git
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

### Building for Testing

#### Android APK
```bash
flutter build apk
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
- **Email**: 
  - abionjanuelleasturias07@gmail.com
  - 22-05633@g.batstate-u.edu.ph
  - 22-01952@g.batstate-u.edu.ph
- **Phone**: 09913028095
- **Documentation**: https://acesse.one/10-ABION-PAPIO-SASTADO-IT332-FinalProject

---

**Developed for Ibaan Market Vendors & Community Multi-Purpose Cooperative (IMVCMPC)**

*Empowering cooperative financial management through technology and analytics.*
