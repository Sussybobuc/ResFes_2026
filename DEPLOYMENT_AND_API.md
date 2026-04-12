# ResFes 2026 - Complete API & Deployment Guide

## 🚀 Quick Start

### Prerequisites
- Python 3.10+
- Groq API key (free, no credit card: https://console.groq.com)
- WiFi network to connect phone + laptop

### Setup

#### 1. Clone & Install
```bash
git clone <repo>
cd ResFes_2026
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install groq flask flask-cors requests python-dotenv Pillow colorama pyOpenSSL
```

#### 2. Configure .env
```bash
cp .env.example .env
# Edit .env and add your GROQ_API_KEY
```

#### 3. Start KB Server (on phone or laptop:5001)
```bash
python kb_server.py
# Runs on: http://<your-ip>:5001
```

#### 4. Start ResFes (on laptop:5050)
```bash
python resfes.py
# Runs on: https://<your-ip>:5050 (self-signed cert)
# Open in browser and accept certificate warning
```

---

## 📡 API Endpoints Reference

### ResFes Main Server (Port 5050)

#### 1. POST /analyze
**Purpose**: Scan homework/textbook image → get Socratic hint + knowledge

**Request**:
```json
{
  "image": "<base64 jpeg image>",
  "subject": "Mathematics",
  "note": "I don't understand this step",
  "use_kb": true
}
```

**Response**:
```json
{
  "ocr_text": "Exercise 2.1: Solve x² + 2x - 8 = 0",
  "subject": "Mathematics",
  "hint": "What values would make this expression equal zero? Have you tried factoring?",
  "flashcard": "What are the roots of x² + 2x - 8?",
  "knowledge": [
    {
      "doc_id": 1,
      "title": "Quadratic_Equations.pdf",
      "snippet": "The quadratic formula: x = (-b ± √(b²-4ac)) / 2a...",
      "relevance": 0.9
    }
  ]
}
```

#### 2. POST /chat
**Purpose**: Multi-turn conversation with Socratic guidance

**Request**:
```json
{
  "message": "How do I factor this?",
  "subject": "Mathematics",
  "history": [
    {"role": "user", "content": "I'm stuck on factoring"},
    {"role": "assistant", "content": "What are the factors of 8?"}
  ],
  "use_kb": true,
  "stream": false
}
```

**Response**:
```json
{
  "reply": "Great question! Let's think about it systematically. Can you list all the factor pairs of 8?",
  "used_kb": true,
  "kb_context": "[Optional if debug=true]"
}
```

#### 3. GET /chat/stream
**Purpose**: Same as `/chat` but with streaming response

**Request**: Same as `/chat` (stream=true is automatic)

**Response**: Server-sent events (SSE) stream

#### 4. GET /health
**Purpose**: Check server status

**Response**:
```json
{
  "status": "ok",
  "model": "llama-4-scout-17b"
}
```

---

### KB Manager Endpoints (Port 5050)

#### 1. POST /kb/upload
**Purpose**: Upload document to local knowledge base

**Request**:
```json
{
  "file": "<base64 file data>",
  "filename": "physics_notes.pdf",
  "file_type": "pdf",
  "subject": "Physics"
}
```

**Response**:
```json
{
  "id": 123,
  "filename": "20260412_105050_physics_notes.pdf",
  "original_name": "physics_notes.pdf",
  "file_type": "pdf",
  "subject": "Physics",
  "file_size": 2048000,
  "page_count": 45
}
```

#### 2. GET /kb/documents
**Purpose**: List uploaded documents

**Query Parameters**:
- `subject` (optional): Filter by subject

**Response**:
```json
{
  "documents": [
    {
      "id": 1,
      "filename": "20260412_105050_physics_notes.pdf",
      "original_name": "physics_notes.pdf",
      "file_type": "pdf",
      "subject": "Physics",
      "content_preview": "Chapter 1: Mechanics...",
      "upload_date": "2026-04-12T10:50:50",
      "file_size": 2048000,
      "page_count": 45
    }
  ]
}
```

#### 3. DELETE /kb/documents/{doc_id}
**Purpose**: Delete a document

**Response**:
```json
{
  "success": true
}
```

#### 4. POST /kb/search
**Purpose**: Search knowledge base

**Request**:
```json
{
  "query": "momentum and energy conservation",
  "subject": "Physics"
}
```

**Response**:
```json
{
  "results": [
    {
      "doc_id": 1,
      "title": "physics_notes.pdf",
      "subject": "Physics",
      "snippet": "Conservation of momentum: p = m*v. In an isolated system...",
      "relevance": 0.95
    }
  ]
}
```

---

### KB Server Endpoints (Port 5001)

**Same as above**, except:
- Port is **5001**
- Designed for phone/Termux/Pydroid
- Includes web UI at `GET /`

---

## 🔧 Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| GROQ_API_KEY | (required) | Groq API authentication key |
| KB_SERVER_URL | "" | URL of remote KB server (e.g., http://192.168.1.100:5001) |
| RESFES_KB_MODE | "auto" | Knowledge base mode: "auto", "local", or "remote" |
| RESFES_DATA_DIR | "./app_data" | Directory for storing documents/database |
| RESFES_CERT_VALID_DAYS | 365 | SSL certificate validity period |

### KB_MODE Behavior

- **"auto"** (default): Use remote KB if KB_SERVER_URL is set, otherwise local
- **"local"**: Only local knowledge base (no network KB)
- **"remote"**: Only remote KB server (must have KB_SERVER_URL)

---

## 🛠️ Deployment Steps

### On Laptop (ResFes Main Server)

```bash
# 1. Install dependencies
pip install -r requirements.txt

# 2. Create .env
cp .env.example .env
# Edit .env - add GROQ_API_KEY and optional KB_SERVER_URL

# 3. Run
python resfes.py

# Access at: https://localhost:5050
```

### On Phone (KB Server - Termux)

```bash
# 1. Install Python
pkg update && pkg install python

# 2. Install dependencies
pip install flask flask-cors

# 3. Copy kb_server.py to phone

# 4. Run
python kb_server.py

# Access at: http://<phone-ip>:5001
# Get IP: ifconfig or ip addr show
```

### On Phone (KB Server - Pydroid 3)

1. Install Pydroid 3 from Play Store
2. Menu → Pip → Install `flask` and `flask-cors`
3. Open `kb_server.py` in Pydroid editor
4. Press ▶️ (Run)
5. Check console for IP address

---

## 🔍 Testing Endpoints

### Using curl/Postman

```bash
# Health check
curl https://localhost:5050/health -k

# Test vision analysis (replace BASE64 with actual image)
curl -X POST https://localhost:5050/analyze \
  -H "Content-Type: application/json" \
  -d '{"image":"data:image/jpeg;base64,...","subject":"Math"}' \
  -k

# Test chat
curl -X POST https://localhost:5050/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"How do I solve quadratics?"}' \
  -k

# List KB documents
curl https://localhost:5050/kb/documents \
  -k
```

---

## ⚠️ SSL/Certificate Notes

- ResFes generates self-signed certificates automatically
- First access will show "untrusted certificate" warning
- **Accept and continue** - this is normal
- Certificates are stored in project root as `cert.pem`, `key.pem`
- Certificate includes SANs for: localhost, hostname, local IPs

---

## 🐛 Troubleshooting

### Camera not working
- Ensure ResFes runs on HTTPS (not HTTP)
- Accept self-signed certificate warning
- Phone and laptop must be on same WiFi network

### KB Server not found
- Check KB_SERVER_URL in .env
- Verify phone IP: `ipconfig` (Windows) or `ifconfig` (Linux/Mac/Termux)
- Test with: `curl http://<phone-ip>:5001/api/health`

### Groq API errors
- Verify GROQ_API_KEY is valid
- Check API quota at https://console.groq.com
- Model used: `meta-llama/llama-4-scout-17b-16e-instruct`

### Import errors
- Recreate venv: `rm -rf venv && python -m venv venv`
- Reinstall: `pip install -r requirements.txt`
- For Kivy issues on Windows: skip kivy, run resfes.py directly

---

## 📚 System Prompts

### Vision Analysis Prompt
- Analyzes image OCR + subject detection
- Returns JSON with `ocr_text`, `subject`, `hint`, `flashcard`
- **Strict Socratic method**: Never gives answers

### Chat System Prompt (Vietnamese)
- Socratic method: questions over answers
- Max 3-4 sentences per response (AR HUD friendly)
- Encourages and motivates students
- Integrates KB context when available
- Natural Vietnamese for high school level

---

## 🚨 Important Notes

1. **No Answer Leaking**: System strictly enforces Socratic method
2. **Stateless**: Each request independent (history passed in request)
3. **Privacy**: All documents stored locally on phone/laptop
4. **Streaming**: `/chat/stream` supports SSE for real-time display
5. **Research Study**: Ready for 20-30 student experiment

