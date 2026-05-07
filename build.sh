#!/bin/bash
# build.sh - Inject environment variables into HTML at build time

# Copy flashcard-app.html to index.html if it doesn't exist
if [ ! -f "index.html" ] && [ -f "flashcard-app.html" ]; then
    cp flashcard-app.html index.html
fi

# Replace placeholder with actual env var values
sed -i "s|window.GROQ_API_KEY = ''|window.GROQ_API_KEY = '${GROQ_API_KEY}'|g" index.html
sed -i "s|window.TOGETHER_API_KEY = ''|window.TOGETHER_API_KEY = '${TOGETHER_API_KEY}'|g" index.html

echo "Environment variables injected into index.html"
