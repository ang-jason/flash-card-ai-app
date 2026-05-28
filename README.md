# 🎯 AI Flashcard Generator
<br>
[![Netlify Status](https://api.netlify.com/api/v1/badges/d8aac65f-83aa-4853-9fd4-fd5febcc85f3/deploy-status)](https://app.netlify.com/projects/togaf-definitions/deploys)
<br>
Interactive flashcard quiz app that generates multiple-choice questions from uploaded files using AI.


## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                        Browser (Client-Side)                     │
│                                                                   │
│  ┌─────────────┐    ┌──────────────┐    ┌──────────────────┐   │
│  │ File Upload │───▶│ File Reader  │───▶│ Base64 Encoding  │   │
│  │  (PDF/TXT)  │    │ (JavaScript) │    │  (for PDFs)      │   │
│  └─────────────┘    └──────────────┘    └──────────────────┘   │
│                                                    │              │
│                                                    ▼              │
│                           ┌────────────────────────────────────┐ │
│                           │    AI Provider Selection           │ │
│                           │  • Claude API (Anthropic)          │ │
│                           │  • Groq API (Llama 3.1 70B)        │ │
│                           │  • Together AI (Llama 3.1 70B)     │ │
│                           └────────────────────────────────────┘ │
│                                                    │              │
│                                                    ▼              │
│                           ┌────────────────────────────────────┐ │
│                           │   Fetch API Call (HTTPS)           │ │
│                           │   Headers: Content-Type, Auth      │ │
│                           │   Body: { model, messages, ... }   │ │
│                           └────────────────────────────────────┘ │
└───────────────────────────────────────┬─────────────────────────┘
                                        │
                                        ▼
                        ┌───────────────────────────────┐
                        │   AI Provider Endpoints       │
                        │   (External APIs)             │
                        └───────────────────────────────┘
                                        │
                                        ▼
                        ┌───────────────────────────────┐
                        │   JSON Response               │
                        │   { questions[], options[],   │
                        │     correct, explanation }    │
                        └───────────────────────────────┘
                                        │
                                        ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Browser Rendering Engine                      │
│                                                                   │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────────┐  │
│  │ Parse JSON   │───▶│ Render Quiz  │───▶│ Timer + Score    │  │
│  │ Questions    │    │ Interface    │    │ Tracking         │  │
│  └──────────────┘    └──────────────┘    └──────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

## Process Flow

```
User Actions                  System Processing                 Output
─────────────────────────────────────────────────────────────────────

1. Upload File
   │
   ├─▶ Validate size (≤60MB)
   │   │
   │   ├─▶ ✓ Show: filename + size       ───▶ File info displayed
   │   └─▶ ✗ Show: error message         ───▶ Red size indicator
   │
2. Click "Generate"
   │
   └─▶ Show selection screen             ───▶ API + Question + Timer options
       │
3. Select API Provider
   │
   ├─▶ Claude    ───▶ No key needed      ───▶ Continue to next step
   ├─▶ Groq      ───▶ Key input shown    ───▶ User enters key
   └─▶ Together  ───▶ Key input shown    ───▶ User enters key
       │
4. Select Question Count
   │
   └─▶ 5 / 10 / 15                       ───▶ Button highlights
       │
5. Select Timer
   │
   └─▶ 15s / 30s / 60s / None            ───▶ Button highlights
       │
6. Click "Start Quiz"
   │
   └─▶ Loading sequence begins...
       │
       ├─▶ "Reading file..."
       ├─▶ "Processing content..."        ───▶ Progress indicators
       ├─▶ "Generating questions..."
       ├─▶ "Sending to AI model..."
       ├─▶ "Analyzing structure..."
       ├─▶ "Extracting concepts..."
       ├─▶ "Formulating questions..."
       ├─▶ "Generating options..."
       ├─▶ "Creating explanations..."
       ├─▶ "Validating questions..."
       └─▶ "Preparing flashcards..."
           │
           └─▶ Quiz interface rendered    ───▶ First question displayed
               │
7. Answer Questions
   │
   ├─▶ Timer starts (if enabled)         ───▶ Countdown display
   │   ├─▶ >10s: Blue
   │   ├─▶ ≤10s: Orange
   │   └─▶ ≤5s:  Red
   │
   ├─▶ User clicks option
   │   │
   │   ├─▶ Correct   ───▶ Green highlight + ✓
   │   │              └─▶ Score +1
   │   │
   │   └─▶ Incorrect ───▶ Red highlight + ✗
   │                  └─▶ Show correct answer (green)
   │
   └─▶ Show explanation                  ───▶ Feedback panel
       │
       └─▶ Click "Next Question"         ───▶ Repeat step 7
           │
8. Quiz Complete
   │
   └─▶ Show final score                  ───▶ Results screen
       • Score: X/Y
       • Percentage: Z%
       • "Try Again" button
```

## Data Flow Diagram

```
┌──────────────┐
│  User File   │
│  (PDF/TXT)   │
└──────┬───────┘
       │
       ▼
┌──────────────────────┐
│  FileReader API      │
│  • readAsDataURL()   │ (PDF → Base64)
│  • readAsText()      │ (TXT → String)
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│  Content Formatter   │
│  • PDF: document obj │
│  • TXT: string       │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│  API Request Builder │
│  {                   │
│    model: "...",     │
│    messages: [...],  │
│    max_tokens: 2000  │
│  }                   │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐         ┌─────────────────┐
│  Fetch API           │────────▶│ AI Provider API │
│  POST request        │◀────────│ (Claude/Groq/   │
└──────┬───────────────┘         │  Together)      │
       │                         └─────────────────┘
       ▼
┌──────────────────────┐
│  Response Parser     │
│  • Extract text      │
│  • Clean markdown    │
│  • Parse JSON        │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│  Questions Array     │
│  [{                  │
│    question: "...",  │
│    options: [...],   │
│    correct: 0-3,     │
│    explanation: ""   │
│  }]                  │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│  Quiz Renderer       │
│  • Display question  │
│  • Render options    │
│  • Start timer       │
│  • Track score       │
└──────────────────────┘
```

## State Management

```
Application State Variables:
├─ uploadedFile        (File object)
├─ selectedApi         ('claude' | 'groq' | 'together')
├─ apiKey              (string)
├─ questionCount       (5 | 10 | 15)
├─ timerSeconds        (0 | 15 | 30 | 60)
├─ questions           (Array of question objects)
├─ currentQuestion     (number: current index)
├─ score               (number: correct answers)
├─ timeRemaining       (number: seconds left)
└─ timerInterval       (setInterval reference)

State Transitions:
INITIAL → FILE_SELECTED → CONFIG_SELECTED → LOADING → QUIZ_ACTIVE → QUIZ_COMPLETE
```

## Features

- **File Upload**: PDF, TXT, DOCX (up to 60MB)
- **AI Question Generation**: Auto-generates questions with explanations
- **Multiple AI Providers**:
  - Claude Sonnet 4 (uses your Claude plan)
  - Groq Llama 3.1 70B (free)
  - Together AI Llama 3.1 70B (free)
- **Customizable Quiz**: 5/10/15 questions
- **Timer Options**: 15s/30s/60s per question or no timer
- **Mobile Responsive**: Works on all devices
- **Real-time Feedback**: Shows correct answers + explanations

## Usage

1. **Upload File** - Select PDF/TXT/DOCX file
2. **Select AI Provider** - Choose Claude, Groq, or Together AI
3. **Enter API Key** (for Groq/Together only) - Or set env variable
4. **Select Questions** - 5, 10, or 15 questions
5. **Select Timer** - 15s, 30s, 60s, or no timer
6. **Start Quiz** - Answer questions and get instant feedback

## API Keys

### Groq (Free)
- Get key: https://console.groq.com/keys
- Or set: `GROQ_API_KEY` env variable

### Together AI (Free)
- Get key: https://api.together.xyz/settings/api-keys
- Or set: `TOGETHER_API_KEY` env variable

### Claude
- Uses your Claude.ai subscription
- No API key needed when running as artifact

## File Size Limits

- Maximum: 60MB
- Display shows: file size vs limit with color indicator
  - Green: under limit
  - Red: over limit

## Timer System

- Countdown display with color changes:
  - Blue: normal time
  - Orange: ≤10 seconds remaining
  - Red: ≤5 seconds remaining
- No penalty when time expires (indicative only)
- Timer stops when answer selected

## Technical Details

- **Type**: Static HTML/CSS/JavaScript (single file)
- **No Backend**: Runs entirely in browser
- **AI Integration**: Direct API calls to providers
- **Storage**: No data persistence

## Loading Status Steps

1. Reading file...
2. Processing content...
3. Generating questions with AI...
4. Sending content to AI model...
5. Analyzing content structure...
6. Extracting key concepts...
7. Formulating questions...
8. Generating answer options...
9. Creating explanations...
10. Validating questions...
11. Preparing flashcards...

## Limitations

- **Groq/Together**: Text files only (no PDF support)
- **Claude**: Supports all file types including PDFs
- **Browser only**: Env variables work server-side only
- **No persistence**: Questions regenerated each session

## Score Tracking

- Real-time score display
- Final score with percentage
- Question-by-question progress indicator

## Project Structure

```
ai-flashcard-app/
├── flashcard-app.html    # Main application (single file)
├── README.md             # Documentation with diagrams
├── EXAMPLES.md           # Usage examples
└── .gitignore           # Git ignore rules
```

## Future Enhancements

Consider contributing or creating issues for:

- [ ] Add support for more file formats
- [ ] Export quiz results to PDF
- [ ] Save/load question sets
- [ ] Add difficulty levels
- [ ] Multi-language support
- [ ] Dark mode theme
