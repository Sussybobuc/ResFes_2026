#!/bin/bash

# Change to project root directory (go up one level from scripts)
cd "$(dirname "$0")/.."

echo "================================================"
echo "  ResFes AR - Quick Start"
echo "================================================"
echo ""
echo "Checking dependencies..."

python3 -c "from OpenSSL import crypto; print('  ✓ pyOpenSSL OK')" 2>/dev/null || {
    echo "  ✗ Missing pyOpenSSL"
    echo "  Installing..."
    pip3 install pyOpenSSL
}

python3 -c "from groq import Groq; print('  ✓ Groq OK')" 2>/dev/null || {
    echo "  ✗ Missing Groq"
    echo "  Installing..."
    pip3 install groq
}

python3 -c "from flask import Flask; print('  ✓ Flask OK')" 2>/dev/null || {
    echo "  ✗ Missing Flask"
    echo "  Installing..."
    pip3 install flask flask-cors
}

echo ""
echo "Starting ResFes AR server..."
echo "Current directory: $(pwd)"
echo ""
python3 app/resfes_app.py
