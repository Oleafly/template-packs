#!/usr/bin/env python3
"""Script kiểm tra bảo mật đơn giản."""

import hashlib
import secrets
from datetime import datetime, timedelta

def generate_token(user_id: int, secret_key: str) -> str:
    """Tạo token xác thực có thời hạn."""
    expiry = datetime.utcnow() + timedelta(hours=24)
    payload = f"{user_id}:{expiry.isoformat()}:{secrets.token_hex(16)}"
    signature = hashlib.sha256(f"{payload}{secret_key}".encode()).hexdigest()
    return f"{payload}:{signature}"

def verify_token(token: str, secret_key: str) -> bool:
    """Xác minh token và kiểm tra thời hạn."""
    try:
        parts = token.rsplit(":", 1)
        payload, signature = parts[0], parts[1]
        expected = hashlib.sha256(f"{payload}{secret_key}".encode()).hexdigest()
        if not secrets.compare_digest(signature, expected):
            return False
        _, expiry_str, _ = payload.split(":", 2)
        return datetime.fromisoformat(expiry_str) > datetime.utcnow()
    except (ValueError, IndexError):
        return False
