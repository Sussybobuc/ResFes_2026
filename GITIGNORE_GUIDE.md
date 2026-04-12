# .gitignore Guide - What Should Be Ignored

## Quick Answer

Your `.gitignore` file should prevent committing:
- **Secrets** (API keys, passwords, certificates)
- **User data** (databases, documents)
- **Generated files** (cache, compiled code, logs)
- **Dependencies** (venv, node_modules)
- **OS files** (Thumbs.db, .DS_Store)

---

## Updated .gitignore Categories

### 🔐 Secrets & Sensitive Files
```gitignore
# Don't commit:
.env                    # Your API keys
config/.env            # Configuration
*.pem                  # SSL certificates
*.key                  # Encryption keys
```

**Why?** If you commit these, anyone with Git access gets your API keys!

### 📦 Virtual Environments
```gitignore
venv/                  # Python environment
venv_test/             # Test environment
env/
ENV/
```

**Why?** 
- 100+ MB of dependencies
- Different on each system
- Regenerate with `pip install -r requirements.txt`

### 🐍 Python Cache & Compiled
```gitignore
__pycache__/           # Python cache
*.pyc                  # Compiled Python
*.pyo
*.pyd
.Python
*.egg-info/
dist/
build/
```

**Why?** Generated automatically, takes space, OS-specific

### 💾 Database Files (User Data)
```gitignore
*.db                   # SQLite databases
*.sqlite
*.sqlite3
knowledge.db           # User documents
```

**Why?** Contains user-specific data, regenerated locally

### 🖥️ IDE & Editor Files
```gitignore
.vscode/               # VS Code settings
.idea/                 # PyCharm settings
*.swp                  # Vim swap files
*.swo
*~
```

**Why?** Personal editor settings, not project code

### 🍎 OS Files
```gitignore
.DS_Store              # macOS
Thumbs.db              # Windows
```

**Why?** OS-specific, created automatically

### 📝 Logs & Temporary
```gitignore
logs/
*.log
*.tmp
temp/
.cache/
```

**Why?** Runtime files, not part of code

---

## Complete .gitignore File

```gitignore
# ═══════════════════════════════════════════════════════════
# Virtual Environments
# ═══════════════════════════════════════════════════════════
venv/
venv_test/
env/
ENV/

# ═══════════════════════════════════════════════════════════
# Environment Variables & Secrets (NEVER COMMIT!)
# ═══════════════════════════════════════════════════════════
.env
.env.local
.env.*.local
config/.env

# ═══════════════════════════════════════════════════════════
# SSL/TLS Certificates (regenerate locally)
# ═══════════════════════════════════════════════════════════
*.pem
*.key
*.crt
cert.pem
key.pem

# ═══════════════════════════════════════════════════════════
# Python Cache & Compiled Files
# ═══════════════════════════════════════════════════════════
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
*.egg-info/
*.egg
dist/
build/

# ═══════════════════════════════════════════════════════════
# Database Files (contain user data)
# ═══════════════════════════════════════════════════════════
*.db
*.sqlite
*.sqlite3
knowledge.db

# ═══════════════════════════════════════════════════════════
# IDE & Editor Files
# ═══════════════════════════════════════════════════════════
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store
Thumbs.db

# ═══════════════════════════════════════════════════════════
# Logs & Temporary Files
# ═══════════════════════════════════════════════════════════
logs/
*.log
*.tmp
temp/
.cache/

# ═══════════════════════════════════════════════════════════
# Frontend (if using npm)
# ═══════════════════════════════════════════════════════════
node_modules/
package-lock.json
yarn.lock

# ═══════════════════════════════════════════════════════════
# Distribution & Build
# ═══════════════════════════════════════════════════════════
dist/
build/
*.tar.gz
*.zip

# ═══════════════════════════════════════════════════════════
# Linting & Coverage
# ═══════════════════════════════════════════════════════════
.pylint
.coverage
htmlcov/

# ═══════════════════════════════════════════════════════════
# Jupyter Notebooks (if used)
# ═══════════════════════════════════════════════════════════
.ipynb_checkpoints/
*.ipynb

# ═══════════════════════════════════════════════════════════
# Miscellaneous
# ═══════════════════════════════════════════════════════════
.env.prod
secrets/
private/
```

---

## What SHOULD Be Committed

✅ **DO commit:**
- `.py` files (source code)
- `.md` files (documentation)
- `requirements.txt` (dependencies list)
- `templates/` (HTML files)
- `.gitignore` (this file!)
- `config/.env.example` (template, no real keys)
- `scripts/` (startup scripts)

❌ **DON'T commit:**
- `venv/` (virtual environment)
- `.env` (real API keys)
- `cert.pem`, `key.pem` (certificates)
- `*.pyc` (compiled Python)
- `__pycache__/` (cache)
- `knowledge.db` (user data)

---

## Critical Security Rules

### 🚨 NEVER Commit
```gitignore
.env                   # Your API keys live here
config/.env            # Groq API key
*.pem                  # SSL certificates
*.key                  # Encryption keys
/secrets/              # Any secret files
```

**Why?** Anyone with repo access gets your credentials!

### ✅ Always Use
```env
# config/.env (ignored)
GROQ_API_KEY=gsk_your_real_key_here

# config/.env.example (committed - safe)
GROQ_API_KEY=gsk_example_key_here
```

---

## Common Mistakes to Avoid

### ❌ MISTAKE: Committed .env with API key
```bash
git push
# 🚨 OH NO! Everyone can see my API key now!
```

**Solution:**
1. Generate new API key (old one is compromised)
2. Delete commit history or use git-filter-branch
3. Add `.env` to .gitignore
4. Never do it again!

### ❌ MISTAKE: Committed venv/ folder
```bash
git push
# 🚨 50 MB uploaded! Very slow!
```

**Solution:**
1. Add `venv/` to .gitignore
2. Remove from git: `git rm -r --cached venv/`
3. Commit: `git commit -m "Remove venv from repo"`
4. Next clone: `pip install -r requirements.txt`

### ❌ MISTAKE: Committed __pycache__/
```bash
git push
# 🚨 Thousands of .pyc files!
```

**Solution:**
1. Add to .gitignore
2. Remove: `git rm -r --cached __pycache__/`
3. Commit

---

## Verification Checklist

### Before Your First Commit
```bash
# Check what's staged
git status

# Verify .gitignore is working
git check-ignore -v *

# Should show:
# .env                      (matched .env pattern)
# cert.pem                  (matched *.pem pattern)
# key.pem                   (matched *.pem pattern)
# venv/                     (matched venv/ pattern)
# __pycache__/              (matched __pycache__/ pattern)
```

### Files You Should See in Git
```bash
git ls-files

# Should show:
# .gitignore
# README.md
# app/resfes_app.py
# app/kb_server_app.py
# frontend/templates/ar_hud.html
# config/.env.example    (safe - no real keys)
# requirements.txt
# scripts/start_resfes.sh
# scripts/start_resfes.bat

# Should NOT show:
# .env                   (contains real keys!)
# cert.pem              (certificate)
# key.pem               (private key)
# venv/                 (dependencies)
# __pycache__/          (cache)
```

---

## Git Commands for .gitignore

### Check if file is ignored
```bash
git check-ignore -v <filename>

# Example:
git check-ignore -v .env
# .env              (matched .env pattern)
```

### Remove accidentally committed file
```bash
# Remove from git (but keep local copy)
git rm --cached <filename>

# Example:
git rm --cached cert.pem

# Then commit
git commit -m "Remove cert.pem from repo"
```

### Remove entire folder
```bash
# Remove from git (but keep local folder)
git rm -r --cached <folder>/

# Example:
git rm -r --cached venv/

# Then commit
git commit -m "Remove venv from repo"
```

### Dry run (see what would be deleted)
```bash
git rm -r --cached --dry-run <folder>/
```

---

## ResFes-Specific Additions

### Already Ignored
✅ `venv/` - Virtual environment  
✅ `.env` - Configuration  
✅ `__pycache__/` - Python cache  
✅ `*.pyc` - Compiled Python  

### Should Be Ignored (Now Added)
✅ `venv_test/` - Test environment  
✅ `cert.pem` - SSL certificate  
✅ `key.pem` - Private key  
✅ `*.db` - Databases  
✅ `.vscode/` - VS Code settings  
✅ `.idea/` - PyCharm settings  
✅ `knowledge.db` - User data  

### Safe to Commit
✅ `config/.env.example` - Template (no real keys)  
✅ `app/` - All Python files  
✅ `frontend/` - All HTML/CSS/JS  
✅ `scripts/` - Startup scripts  
✅ `.gitignore` - This file  
✅ `README.md` - Documentation  
✅ `requirements.txt` - Dependencies  

---

## Template for .env.example

Create this to help others set up:

```env
# config/.env.example
# Copy to .env and fill in your values

# Groq API Configuration
# Get free API key from: https://console.groq.com
GROQ_API_KEY=gsk_example_key_here

# HuggingFace Token (optional)
HF_TOKEN=hf_example_token_here

# Knowledge Base Configuration
KB_SERVER_URL=

# KB Mode: 'auto', 'local', or 'remote'
RESFES_KB_MODE=auto

# Local Data Directory
RESFES_DATA_DIR=./knowledge

# Certificate Configuration
RESFES_CERT_VALID_DAYS=365
RESFES_REGEN_CERT=false
RESFES_CERT_DIR=.
```

Users copy this to `.env` and fill in their real keys.

---

## Summary Table

| File/Folder | Commit? | Why |
|-------------|---------|-----|
| `.env` | ❌ NO | Contains API keys |
| `config/.env` | ❌ NO | Contains API keys |
| `config/.env.example` | ✅ YES | Template, no real keys |
| `cert.pem` | ❌ NO | SSL certificate |
| `key.pem` | ❌ NO | Private key (SECRET!) |
| `venv/` | ❌ NO | Dependencies, regenerate locally |
| `venv_test/` | ❌ NO | Test environment |
| `__pycache__/` | ❌ NO | Generated cache |
| `*.pyc` | ❌ NO | Compiled Python |
| `knowledge.db` | ❌ NO | User data |
| `app/*.py` | ✅ YES | Source code |
| `frontend/` | ✅ YES | UI code |
| `README.md` | ✅ YES | Documentation |
| `requirements.txt` | ✅ YES | Dependencies list |
| `.gitignore` | ✅ YES | Ignore rules |
| `scripts/` | ✅ YES | Startup scripts |

---

## Best Practices

### ✅ DO
- Review `.gitignore` before first commit
- Use `.env.example` as a template
- Add sensitive files immediately after discovery
- Test with `git check-ignore`
- Include `.gitignore` in first commit

### ❌ DON'T
- Commit `.env` with real API keys
- Commit certificates (`*.pem`, `*.key`)
- Commit virtual environments
- Commit user data (`.db` files)
- Forget to test before pushing

---

## If You Accidentally Committed Secrets

### 🚨 EMERGENCY STEPS
1. **Generate new API key** (old one is compromised)
   - Go to console.groq.com
   - Delete old key
   - Create new key
   - Update `.env` locally

2. **Remove from Git history**
   - Use git-filter-branch or BFG Repo-Cleaner
   - Rewrite history to remove file
   - Force push (dangerous - coordinate with team)

3. **Enable Branch Protection**
   - GitHub: Settings → Branch protection
   - Require .gitignore check before merge

---

## Test Your .gitignore

```bash
# Before committing, verify:
git status
# Should NOT show: .env, cert.pem, venv, etc.

git check-ignore -v .env
# Should show it's ignored

git ls-files | grep -E "(\.env|cert\.pem|key\.pem|venv)"
# Should show nothing (empty)
```

---

## Questions Answered

**Q: Can I commit .env.example?**  
**A:** YES! It's a template with no real keys. Helps others set up.

**Q: What if I need .env tracked?**  
**A:** NO! Never track .env. Use .env.example template instead.

**Q: Should I commit knowledge.db?**  
**A:** NO! It's user data. Users should generate their own.

**Q: Can I commit venv/?**  
**A:** NO! Huge (~100MB+), OS-specific. Use requirements.txt.

**Q: What about cert.pem?**  
**A:** NO! Self-signed, regenerated locally. Users generate their own.

---

**Your `.gitignore` is now updated! Ready for safe commits. 🚀**
