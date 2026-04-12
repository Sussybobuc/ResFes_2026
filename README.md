# 🎓 ResFes AR Learning Assistant (2026)

> **AI-powered AR learning tool with Socratic Method**  
> Scan textbook problems → Get smart hints (NEVER give full answers)  
> Built for **ResFes 2026** — Ready for real AR glasses.

---

## 🚀 Quick Start (5 minutes)

### 1️⃣ Install Dependencies
```bash
cd D:\ResFes_2026
pip install -r requirements.txt
```

### 2️⃣ Configure API Key
1. Get free API key: https://console.groq.com (no credit card needed)
2. Add to `config/.env`:
```env
GROQ_API_KEY=your_key_here
```

### 3️⃣ Start Apps
```bash
# Terminal 1: Main ResFes App
python app/resfes_app.py          # https://localhost:5050

# Terminal 2: Knowledge Base Server
python app/kb_server_app.py       # http://localhost:5001
```

### 4️⃣ Open Browser
- **ResFes:** http://localhost:5050 (Main interface)
- **KB Server:** http://localhost:5001 (Upload documents)

**Done! 🎉**

---

## 📂 Project Structure

```
ResFes_2026/
├── app/                          ← RUN THESE APPS
│   ├── resfes_app.py            (Main app - port 5050)
│   ├── kb_server_app.py         (KB Server - port 5001)
│   ├── knowledge_base.py        (KB logic)
│   └── main_launcher.py         (CLI launcher)
│
├── frontend/                     ← EDIT UI HERE
│   ├── templates/
│   │   └── ar_hud.html          (Main HTML interface)
│
├── config/                       ← PUT API KEY HERE
│   └── .env                      (Your config)
│
├── knowledge/                    ← DOCUMENTS STORED HERE
│   ├── uploads/                 (User-uploaded files)
│   └── knowledge.db             (Search index)
│
├── scripts/                      ← START FROM HERE
│   ├── start_resfes.bat         (Windows)
│   └── start_resfes.sh          (Linux/Mac)
│
├── tests/                        ← ADD TESTS HERE
├── requirements.txt
└── README.md
```

---

## ⚙️ Setup Details

### System Requirements
- **Python:** 3.10+
- **OS:** Windows, macOS, or Linux
- **Internet:** Required for Groq API
- **Browser:** Chrome, Firefox, Safari, Edge

### Virtual Environment (Recommended)
```bash
# Create
python -m venv venv

# Activate
venv\Scripts\activate              # Windows
# or
source venv/bin/activate           # macOS/Linux

# Install
pip install -r requirements.txt
```

### Get Groq API Key
1. Visit https://console.groq.com
2. Click "Sign Up" (free, no credit card)
3. Verify email
4. Go to "API Keys" in sidebar
5. Click "Create API Key"
6. Copy key (starts with `gsk_`)
7. Paste in `config/.env`

### Configure `.env`
```env
# Your Groq API key
GROQ_API_KEY=gsk_your_key_here

# Optional: HuggingFace token
HF_TOKEN=hf_your_token_here

# Optional: KB Server URL (if running on different machine)
KB_SERVER_URL=

# Knowledge base mode: 'auto', 'local', or 'remote'
RESFES_KB_MODE=auto

# Local data directory
RESFES_DATA_DIR=./knowledge
```

---

## 🎯 How to Use

### Upload Documents to Knowledge Base
1. Visit http://localhost:5001
2. Click "Upload"
3. Select file (PDF, TXT, images)
4. Choose subject
5. Done!

### Scan/Analyze Image
1. Visit http://localhost:5050
2. Click camera icon or upload image
3. Select subject (optional)
4. AI analyzes and shows:
   - Extracted text (OCR)
   - Socratic hints (never full answers)
   - Related documents from KB

### Voice Control
- Say "Hey ResFes" to activate
- Say commands (Vietnamese support)
- Gesture recognition with hand movements

### Hand Gestures
- ☝️ **Point finger** → Move cursor
- 🤏 **Pinch** → Click button
- 🖐️ **Open hand** → Toggle mic
- ✌️ **V sign** → Scan immediately

---

## 🔧 Troubleshooting

| Problem | Solution |
|---------|----------|
| **Port already in use** | Change port in code or use different terminal |
| **API key error** | Get new key from console.groq.com |
| **Template not found** | Make sure `frontend/templates/ar_hud.html` exists |
| **Can't connect KB Server** | Ensure both apps running, check URLs |
| **Camera not working** | Try different browser or use Upload instead |
| **Import errors** | Run `pip install -r requirements.txt` |
| **Python not found** | Install Python 3.10+ from python.org |

---

## 📁 File Locations Guide

| Need | Location |
|------|----------|
| **Start main app** | `python app/resfes_app.py` |
| **Start KB Server** | `python app/kb_server_app.py` |
| **Edit config** | `config/.env` |
| **Edit UI** | `frontend/templates/ar_hud.html` |
| **Add AI logic** | Create in `app/` or new file |
| **Upload documents** | `knowledge/uploads/` |
| **Run tests** | `python -m pytest tests/` |
| **API key** | `config/.env` → `GROQ_API_KEY` |

---

## 🌐 Service Endpoints

| Service | URL | Purpose |
|---------|-----|---------|
| **ResFes** | http://localhost:5050 | Main app (camera, hints, voice) |
| **KB Server** | http://localhost:5001 | Upload & search documents |

---

## ✨ Features

✅ **Scan textbook problems** with camera or upload  
✅ **AI analysis** via Groq LLaMA (Socratic hints only)  
✅ **Knowledge base** — upload & search documents  
✅ **Voice control** — "Hey ResFes" wake word  
✅ **Gesture recognition** — Hand gestures for control  
✅ **Auto subject detection** — AI identifies the subject  
✅ **Socratic method** — Smart hints, never full answers  
✅ **Multi-language** — Vietnamese + English support  

---

## 📊 Architecture

```
User (Glasses/Phone/Browser)
       ↓
ResFes App (port 5050)
       ↓
┌──────────────────────────────────┐
│ Vision Processing                │
│ - Camera capture                 │
│ - Image upload                   │
└──────────────────────────────────┘
       ↓
Groq LLaMA 4 Scout AI
       ↓
┌──────────────────────────────────┐
│ Response Generation              │
│ - OCR (text extraction)          │
│ - Socratic hints                 │
│ - Subject detection              │
└──────────────────────────────────┘
       ↓ (Optional)
KB Server (port 5001)
       ↓
Knowledge Base Search
       ↓
Related Documents
```

---

## 🔐 Security

- **API Keys:** Stored in `config/.env` (NOT committed to git)
- **HTTPS:** Self-signed certificate for camera access
- **No data logging:** Local processing only
- **Privacy:** Images processed locally, not stored

---

## 📚 Tech Stack

- **Backend:** Python 3.10+, Flask
- **AI/Vision:** Groq LLaMA 4 Scout
- **Frontend:** Vanilla JavaScript, HTML5
- **Real-time:** WebSocket support
- **Media:** MediaPipe (gesture recognition)
- **TTS/STT:** Web APIs (browser native)

---

## 🚀 Deployment

### Local Development
```bash
python app/resfes_app.py
```

### Windows Startup Script
```bash
scripts\start_resfes.bat
```

### Linux/Mac Startup Script
```bash
bash scripts/start_resfes.sh
```

### Network Access
- Same WiFi: Access via local IP
  ```
  https://192.168.x.x:5050
  http://192.168.x.x:5001
  ```
- Note: Accept certificate warning on first HTTPS access

---

## ❓ Common Questions

**Q: Where do I put my API key?**  
A: In `config/.env` file, the `GROQ_API_KEY` field

**Q: How do I upload documents?**  
A: Visit http://localhost:5001 → Upload section

**Q: Where are my uploaded files stored?**  
A: In `knowledge/uploads/` folder, organized by subject

**Q: Can I use this on real AR glasses?**  
A: Yes! Just update the camera source in JavaScript

**Q: Is my data private?**  
A: Yes, images processed locally, not stored or logged

**Q: Can I add custom features?**  
A: Yes! Add to `app/resfes_app.py` or create new modules

**Q: Why no full answers?**  
A: Socratic method encourages learning, not memorization

---

## 🐛 Known Issues & Workarounds

| Issue | Workaround |
|-------|-----------|
| Camera permission denied | Use Upload instead, check browser permissions |
| Slow first response | LLaMA loads on first call, be patient |
| Mobile memory limited | Simplify image size or use smaller models |
| KB search slow on large DB | Index more efficiently or trim old documents |

---

## 📖 Documentation Map

This is the **complete and only documentation file** you need. It contains:
- ✅ Quick start (5 min)
- ✅ Full setup guide
- ✅ Feature documentation
- ✅ Troubleshooting
- ✅ File locations
- ✅ Architecture overview

---

## 🔗 Resources

- **Groq Console:** https://console.groq.com
- **Flask Docs:** https://flask.palletsprojects.com
- **Python Docs:** https://python.org/docs
- **Project Repo:** (link to GitHub)

---

## 📝 License & Credits

Built for **ResFes 2026** — Educational Technology Initiative

Research papers included in `References/` folder for context:
- Digital Transformation in Higher Education
- Student Engagement through AR
- Self-Directed Learning Optimization

---

## ⚡ Quick Commands Reference

```bash
# Setup
python -m venv venv              # Create environment
source venv/bin/activate         # Activate (Linux/Mac)
venv\Scripts\activate            # Activate (Windows)
pip install -r requirements.txt  # Install all packages

# Run Apps
python app/resfes_app.py         # Main app (5050)
python app/kb_server_app.py      # KB Server (5001)

# Tests
python -m pytest tests/          # Run all tests
python -m pytest tests/test_x.py # Run specific test

# Cleanup
deactivate                       # Exit venv
rm -rf venv                      # Delete venv (Linux/Mac)
rmdir /s venv                    # Delete venv (Windows)
```

---

## 🎓 Learning Path

1. **Just want to run it?** → Start with "Quick Start" above
2. **Want to understand it?** → Read "Architecture" section
3. **Want to modify it?** → Check "File Locations Guide"
4. **Want to debug it?** → See "Troubleshooting" section
5. **Want to deploy it?** → Read "Deployment" section

---

## 🤝 Contributing

To contribute:
1. Modify code in `app/` or `frontend/templates/`
2. Add tests in `tests/`
3. Test thoroughly before committing
4. Update this README if needed
5. Keep config in `.env` (never commit secrets)

---

## ✅ Verification Checklist

- [ ] Python 3.10+ installed
- [ ] Dependencies installed: `pip install -r requirements.txt`
- [ ] API key from console.groq.com
- [ ] API key added to `config/.env`
- [ ] Can run `python app/resfes_app.py` (no errors)
- [ ] Can run `python app/kb_server_app.py` (no errors)
- [ ] Can access http://localhost:5050 in browser
- [ ] Can access http://localhost:5001 in browser
- [ ] Can upload a test document
- [ ] Can analyze a test image

---

**Ready to get started? Run the Quick Start section above! 🚀**

---

*Last Updated: 2026-04-12*  
*For issues or questions, check the Troubleshooting section above.*
