# Render Deployment Instructions

## Quick Deploy to Render

Render can host the static HTML app for free.

### Option 1: Deploy from GitHub (Recommended)

1. **Push to GitHub first**
   ```bash
   # Follow GITHUB_SETUP.md instructions
   ```

2. **Create Render Account**
   - Go to https://render.com
   - Sign up with GitHub

3. **Create New Static Site**
   - Click "New +" → "Static Site"
   - Connect your GitHub repository
   - Repository: `your-username/ai-flashcard-app`

4. **Configure Build Settings**
   - **Name**: `ai-flashcard-app`
   - **Branch**: `main`
   - **Build Command**: `bash build.sh`
   - **Publish Directory**: `.`

5. **Add Environment Variables**
   - Click "Environment" tab
   - Add secrets:
     - Key: `GROQ_API_KEY`, Value: `your-groq-key`
     - Key: `TOGETHER_API_KEY`, Value: `your-together-key`

6. **Deploy**
   - Click "Create Static Site"
   - Wait 1-2 minutes for deployment
   - Access at: `https://ai-flashcard-app.onrender.com`

### Option 2: Manual Deploy (Without Git)

1. **Create Render Account**
   - Go to https://render.com
   - Sign up

2. **Create New Static Site**
   - Click "New +" → "Static Site"
   - Choose "Public Git repository"
   - Or connect via GitHub (easier)

3. **Upload Files Manually**
   - Not directly supported - must use Git
   - Recommendation: Use GitHub method

### Configure Custom Domain (Optional)

1. Go to your static site dashboard
2. Click "Settings"
3. Scroll to "Custom Domain"
4. Add your domain
5. Update DNS records as instructed

## Environment Variables

Since this is a static site, environment variables don't work traditionally. 

### For API Keys:

**Option A**: Users enter keys at runtime (current implementation)

**Option B**: Create a simple backend
- Deploy a Node.js/Python backend on Render
- Store API keys in Render environment variables
- Proxy API requests through backend

## Alternative: Render.yaml (Infrastructure as Code)

Create `render.yaml` in your repository root:

```yaml
services:
  - type: web
    name: ai-flashcard-app
    env: static
    buildCommand: ""
    staticPublishPath: .
    routes:
      - type: rewrite
        source: /*
        destination: /flashcard-app.html
```

Push to GitHub, and Render will auto-deploy.

## Post-Deployment Checklist

- [ ] Test file upload functionality
- [ ] Test all 3 API providers (Claude, Groq, Together)
- [ ] Verify mobile responsiveness
- [ ] Test timer functionality
- [ ] Confirm all loading states work
- [ ] Check console for errors

## Troubleshooting

### App not loading
- Check publish directory is set to `.`
- Verify `flashcard-app.html` is in repository root

### API calls failing
- CORS errors are expected for Claude API from static site
- Use claude.ai artifacts or deploy backend for Claude
- Groq and Together should work if keys provided

### File upload not working
- Static sites work fine with file upload
- Files processed in browser, not server

## Free Tier Limits

Render free tier includes:
- ✓ Unlimited static sites
- ✓ Auto-deploy from Git
- ✓ Free SSL certificate
- ✓ Global CDN
- ✓ 100GB bandwidth/month

## Upgrade Path

If you need backend features:
1. Convert to Web Service (not static)
2. Add Node.js/Python backend
3. Store API keys server-side
4. Proxy AI API requests

Cost: $7/month for Web Service

## Support

- Render Docs: https://render.com/docs/static-sites
- Render Community: https://community.render.com
