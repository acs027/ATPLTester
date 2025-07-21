# ATPLTester

ATPLTester is a modern iOS app designed to help users prepare for the Airline Transport Pilot License (ATPL) exams. Built with SwiftUI and SwiftData, it offers a clean, efficient, and user-friendly experience for studying, practicing, and reviewing ATPL questions across all major subjects.

<p align="center">
    <img alt="Simulator Screenshot - iPhone 16 - 2025-07-11 at 15 15 17" src="https://github.com/user-attachments/assets/d141107f-fbbf-428a-8eca-fa57a90dde03" width="300" />
    <img alt="Simulator Screenshot - iPhone 16 - 2025-07-11 at 15 19 02" src="https://github.com/user-attachments/assets/00aac982-79a4-42b6-84cd-534879fde3a2" width="300" />
    <img alt="Simulator Screenshot - iPhone 16 - 2025-07-11 at 15 18 42" src="https://github.com/user-attachments/assets/457a3bfb-a305-4f85-a7f7-234f23a94759" width="300" />
</p>

## Features

- **Lesson Selection:** Choose from all ATPL subjects, including Air Law, Meteorology, Navigation, Human Performance, and more.
- **Exam Creation:** Generate custom exams per lesson with a selected number of questions.
- **Question Practice:** Answer multiple-choice questions with support for figures and explanations.
- **Progress Tracking:** Track your correct/incorrect answers and review past exams.
- **Review Mode:** Revisit incorrect or flagged questions for targeted practice.
- **Modern UI:** Built with SwiftUI, supporting dark mode, dynamic type, and all device sizes.
- **Data Persistence:** Uses SwiftData for fast, secure, and reliable local storage.

## App Structure

```
ATPLTester/
├── App/                # App entry point and main scene
├── Core/               # Core data models and data management
│   └── Data/
│       ├── SwiftData/  # SwiftData models (Exam, Question, UserAnswer)
│       ├── DTO/        # Data transfer objects
│       └── JSON/       # Static data (if any)
├── Features/           # Main app features, each in its own folder
│   ├── Exam/           # Exam taking and logic
│   ├── ExamList/       # Exam list, creation, and progress
│   ├── LessonList/     # Lesson selection and navigation
│   ├── Question/       # Question display and figures
│   └── Review/         # Review incorrect/flagged questions
├── Assets.xcassets/    # App icons, images, and assets
├── Preview Content/    # SwiftUI preview assets
└── Info.plist          # App configuration
```

## Main Models

- **Lesson:** Enum representing all ATPL subjects, each with a unique ID and display name.
- **Question:** Stores question text, options, correct answer, source, subject, and figure reference.
- **Exam:** Represents a user exam session, including questions, answers, scores, and timestamps.
- **UserAnswer:** Tracks user responses per exam and question.

## Architecture

- **MVVM:** Each feature uses the Model-View-ViewModel pattern for clean separation of concerns.
- **SwiftUI First:** All UI is built with SwiftUI, leveraging previews and modern layout techniques.
- **SwiftData:** All persistent data is managed with SwiftData models for performance and reliability.

## Getting Started

1. **Requirements:** Xcode 16+, iOS 18+
2. **Clone the repository:**  
   ```sh
   git clone https://github.com/acs027/ATPLTester.git
   ```
3. **Open in Xcode:**  
   Open `ATPLTester.xcodeproj`.
4. **Build & Run:**  
   Select a simulator or device and run the app.

