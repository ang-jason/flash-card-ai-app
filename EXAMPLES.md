# Usage Examples

## Example 1: Using with Claude (No API Key Required)

1. Open `flashcard-app.html` in browser
2. Upload your study material (PDF/TXT)
3. Click "Generate Flashcards"
4. Select "Claude (Sonnet 4)"
5. Choose 10 questions
6. Choose 30s timer
7. Click "Start Quiz"

## Example 2: Using with Groq (Free API)

1. Get free API key from https://console.groq.com/keys
2. Open `flashcard-app.html` in browser
3. Upload your study material
4. Click "Generate Flashcards"
5. Select "Groq (Llama 3.1 70B)"
6. Enter your API key
7. Choose question count and timer
8. Click "Start Quiz"

## Example 3: Using with Together AI (Free API)

1. Get free API key from https://api.together.xyz/settings/api-keys
2. Open `flashcard-app.html` in browser
3. Upload your study material (text files only)
4. Click "Generate Flashcards"
5. Select "Together (Llama 3.1 70B)"
6. Enter your API key
7. Choose question count and timer
8. Click "Start Quiz"

## Supported File Types

- **PDF**: Up to 60MB (Claude only)
- **TXT**: Up to 60MB (all providers)
- **DOCX**: Up to 60MB (Claude only)

Note: Groq and Together AI only support text files due to API limitations.

## Timer Behavior

- **15s**: Fast-paced quiz, good for memorization
- **30s**: Balanced timing for thinking
- **60s**: Extended time for complex questions
- **No Timer**: Unlimited time per question

The timer is purely indicative - no penalty for running out of time.
