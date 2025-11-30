# Kasho 💰

**Smart personal finance management with AI-powered insights**

Kasho is a modern, beautiful finance tracking app built with Flutter, Supabase, and Gemini AI. Track your expenses, analyze spending patterns, and get intelligent insights about your financial habits.

## 🌟 Features

### Current (MVP)
- ✨ **Beautiful Dashboard** - Revolut-style interface with monthly spending overview
- 🌓 **Dark/Light Mode** - Automatic theme switching
- 📊 **Transaction Tracking** - Track income and expenses
- 🏷️ **Categories** - Predefined Portuguese categories with custom icons
- 📱 **iOS Optimized** - Native feel on iPhone

### Coming Soon
- 📸 **Receipt Scanning** - AI-powered receipt analysis with Gemini Vision
- 🤖 **Smart Categorization** - Automatic transaction categorization
- 📈 **Analytics & Insights** - Charts and AI-generated financial insights
- 💬 **Financial Chatbot** - Ask questions about your spending
- 🏦 **Bank Integration** - Auto-sync with BPI via SIBS API (PSD2)
- 📄 **PDF Import** - Import bank statements automatically

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.35.7 or higher)
- Dart SDK (3.9.2 or higher)
- Supabase account (free tier works!)
- Gemini API key (free from Google AI Studio)

### Installation

1. **Clone and navigate:**
   ```bash
   cd /home/pin4/Documents/LDTS/kasho
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Setup Supabase:**
   - Create a project at [supabase.com](https://supabase.com)
   - Run the SQL in `supabase/schema.sql` in your Supabase SQL editor
   - Copy your Project URL and anon key
   - Update `lib/core/config/supabase_config.dart`:
     ```dart
     static const String supabaseUrl = 'YOUR_PROJECT_URL';
     static const String supabaseAnonKey = 'YOUR_ANON_KEY';
     ```

4. **Setup Gemini AI:**
   - Get your API key from [AI Studio](https://aistudio.google.com/apikey)
   - Update `lib/core/config/gemini_config.dart`:
     ```dart
     static const String apiKey = 'YOUR_GEMINI_API_KEY';
     ```

5. **Run the app:**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── core/
│   ├── theme/           # App theming (dark/light)
│   └── config/          # Supabase & Gemini configuration
├── features/
│   ├── dashboard/       # Home screen
│   ├── transactions/    # Add/view transactions
│   └── analytics/       # Charts and insights
└── shared/
    ├── models/          # Data models (Transaction, Category)
    └── widgets/         # Reusable UI components
```

## 🎨 Design Philosophy

Kasho follows modern fintech design principles:
- **Premium aesthetics** - Inspired by Revolut, N26, and modern banking apps
- **Smooth animations** - Micro-interactions for better UX
- **Color psychology** - Vibrant green for money/growth, clear category colors
- **Portuguese-first** - Built for Portuguese users

## 🔐 Privacy & Security

- **Row Level Security** - Supabase RLS ensures data privacy
- **Local-first option** - Can work offline with local SQLite (future)
- **No data selling** - Your financial data stays yours
- **Open source** - (if you decide to make it public later)

## 🛣️ Roadmap

### Phase 1: MVP (Current)
- [x] Project setup
- [x] Theme system
- [x] Dashboard UI
- [ ] Add transaction feature
- [ ] Transaction list
- [ ] Basic analytics

### Phase 2: AI Features
- [ ] Receipt scanning with Gemini Vision
- [ ] Auto-categorization
- [ ] Financial insights chatbot
- [ ] PDF statement import

### Phase 3: Banking Integration
- [ ] SIBS API Market integration (BPI)
- [ ] Auto-sync transactions
- [ ] Multi-bank support

### Phase 4: Launch Ready
- [ ] Onboarding flow
- [ ] Push notifications
- [ ] Widgets (iOS home screen)
- [ ] Share with family/friends
- [ ] Export data (CSV/PDF)

## 🛠️ Tech Stack

- **Frontend:** Flutter 3.35.7 (Dart 3.9.2)
- **State Management:** Riverpod 2.6.1
- **Navigation:** go_router 14.6.2
- **Backend:** Supabase (PostgreSQL + Auth + Storage)
- **AI:** Google Gemini API (Vision + Pro)
- **Charts:** fl_chart 0.70.1

## 📝 License

This is a personal project. If you want to use it, reach out!

## 🤝 Contributing

Currently a solo project, but open to collaboration!

---

**Made with 💚 by pin4**

*"Keep your Kasho in check"* 💰✨
