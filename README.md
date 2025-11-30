# Kasho 💰

**Smart personal finance management with AI-powered insights**

Kasho is a modern, beautiful finance tracking app built with Flutter, Supabase, and Gemini AI. Track your expenses, analyze spending patterns, and get intelligent insights about your financial habits.

## 🌟 Features

### Current (MVP)
- ✨ **Beautiful Dashboard** - Bank-style interface with monthly spending overview
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
- 🌍 **Multiple Languages** - English support 

## 🎨 Design Philosophy

Kasho follows modern fintech design principles:
- **Premium aesthetics** - Inspired by Revolut, N26, and modern banking apps
- **Smooth animations** - Micro-interactions for better UX
- **Color psychology** - Vibrant green for money/growth, clear category colors
- **Portuguese-first** - Built for Portuguese users

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.35.7 or higher)
- Dart SDK (3.9.2 or higher)
- Supabase account (free tier works!)
- Gemini API key (free from Google AI Studio)

### Installation

1. **Clone the repository:**
   ```bash
   git clone git@github.com:R0drig0-P/Kasho.git
   cd Kasho
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Setup environment variables:**
   - Copy the example file:
     ```bash
     cp .env.example .env
     ```
   - Edit `.env` and add your credentials:
     ```bash
     SUPABASE_URL=https://your-project.supabase.co
     SUPABASE_ANON_KEY=your_anon_key_here
     GEMINI_API_KEY=your_gemini_api_key_here
     ```

4. **Setup Supabase:**
   - Create a project at [supabase.com](https://supabase.com)
   - Go to **SQL Editor** and run the schema in `supabase/schema.sql`
   - Get your credentials from **Project Settings > API**:
     - **Project URL** → Add to `.env` as `SUPABASE_URL`
     - **anon public key** → Add to `.env` as `SUPABASE_ANON_KEY`

5. **Setup Gemini AI:**
   - Get your API key from [AI Studio](https://aistudio.google.com/apikey)
   - Add it to `.env` as `GEMINI_API_KEY`

6. **Run the app:**
   ```bash
   flutter run
   ```

> **🔒 Security Note:** The `.env` file contains sensitive credentials and is gitignored. Never commit it to version control!

## 🔐 Privacy & Security

- **Row Level Security** - Supabase RLS ensures data privacy
- **Local-first option** - Can work offline with local SQLite (future)
- **No data selling** - Your financial data stays yours
- **Open source** - (if you decide to make it public later)

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

Currently a personal project, but open to suggestions and feedback!

---

**Made by pin4**

*"Keep your Kasho in check"* 💰✨
