# GitHub Setup Instructions

## Quick Start

### Option 1: Download Archive
Download `ai-flashcard-app.tar.gz` and extract files to your local machine.

### Option 2: Use Individual Files
Download these files:
- `flashcard-app.html` - Main application
- `README.md` - Documentation
- `EXAMPLES.md` - Usage examples
- `.gitignore` - Git ignore rules

## Create GitHub Repository

### 1. Create New Repository on GitHub
```bash
# Go to github.com and create new repository
# Repository name: ai-flashcard-app
# Description: AI-powered flashcard quiz generator
# Public or Private: Your choice
# Don't initialize with README (we already have one)
```

### 2. Initialize Local Repository
```bash
# Extract files (if using archive)
tar -xzf ai-flashcard-app.tar.gz
cd ai-flashcard-app

# Or create new directory with files
mkdir ai-flashcard-app
cd ai-flashcard-app
# Copy all files here

# Initialize git
git init
git add .
git commit -m "Initial commit: AI Flashcard Generator app"
```

### 3. Push to GitHub
```bash
# Add remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/ai-flashcard-app.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Enable GitHub Pages (Optional)

To host the app online for free:

1. Go to your repository on GitHub
2. Click "Settings"
3. Scroll to "Pages" section
4. Under "Source", select "main" branch
5. Click "Save"
6. Your app will be live at: `https://YOUR_USERNAME.github.io/ai-flashcard-app/flashcard-app.html`

## Project Structure

```
ai-flashcard-app/
├── flashcard-app.html    # Main application (single file)
├── README.md             # Documentation with diagrams
├── EXAMPLES.md           # Usage examples
└── .gitignore           # Git ignore rules
```

## Recommended Repository Settings

### Topics (for discoverability)
Add these topics to your repository:
- `flashcards`
- `ai`
- `quiz`
- `education`
- `claude`
- `llama`
- `javascript`
- `html5`

### Description
```
🎯 AI-powered flashcard quiz generator. Upload files, generate questions with Claude/Groq/Together AI, and test your knowledge with customizable quizzes.
```

### Repository Features
- ✅ Issues
- ✅ Projects (if you want to track improvements)
- ✅ Wikis (for additional documentation)

## License Recommendation

Consider adding a license file. Common choices:
- **MIT License**: Very permissive, allows commercial use
- **Apache 2.0**: Similar to MIT but with patent protection
- **GPL v3**: Requires derivative works to be open source

To add a license:
1. Click "Add file" → "Create new file"
2. Name it `LICENSE`
3. Click "Choose a license template"
4. Select your preferred license
5. Commit the file

## Future Enhancements

Consider creating issues for:
- [ ] Add support for more file formats
- [ ] Export quiz results to PDF
- [ ] Save/load question sets
- [ ] Add difficulty levels
- [ ] Multi-language support
- [ ] Dark mode theme
