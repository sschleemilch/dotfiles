#!/usr/bin/env python3
import json
import urllib.request
from datetime import datetime
from pathlib import Path

CACHE = Path.home() / ".cache/sschleemilch/weather.json"

# Mapping of WMO weather interpretation codes to Material Symbols icon names
WEATHER_CODE_ICONS = {
    0: "clear_day",
    1: "partly_cloudy_day",
    2: "partly_cloudy_day",
    3: "cloud",
    45: "foggy",
    48: "foggy",
    51: "rainy_light",
    53: "rainy",
    55: "rainy_heavy",
    56: "weather_mix",
    57: "weather_mix",
    61: "rainy_light",
    63: "rainy",
    65: "rainy_heavy",
    66: "weather_mix",
    67: "weather_mix",
    71: "weather_snowy",
    73: "weather_snowy",
    75: "weather_snowy",
    77: "snowing",
    80: "rainy_light",
    81: "rainy",
    82: "rainy_heavy",
    85: "weather_snowy",
    86: "weather_snowy",
    95: "thunderstorm",
    96: "thunderstorm",
    99: "thunderstorm",
}

URL = (
    "https://api.open-meteo.com/v1/forecast"
    "?latitude=48.1374&longitude=11.5755"
    "&current=temperature_2m,weather_code"
    "&timezone=Europe%2FBerlin"
    "&forecast_days=0"
)

CACHE_TTL_SECONDS = 3600


def load_cache() -> dict | None:
    if not CACHE.exists():
        return None
    cached = json.loads(CACHE.read_text())
    cached_at = cached.get("cached_at")
    if cached_at is None:
        return None
    age = datetime.now().timestamp() - cached_at
    if age > CACHE_TTL_SECONDS:
        return None
    return cached


def save_cache(data: dict) -> None:
    CACHE.parent.mkdir(parents=True, exist_ok=True)
    CACHE.write_text(json.dumps(data))


def fetch_and_cache() -> dict:
    with urllib.request.urlopen(URL, timeout=10) as resp:
        data = json.loads(resp.read())

    payload = {
        "cached_at": datetime.now().timestamp(),
        "temperature": data["current"]["temperature_2m"],
        "weather_code": data["current"]["weather_code"],
    }
    save_cache(payload)
    return payload


def get_weather() -> dict:
    cached = load_cache()
    if cached is None:
        cached = fetch_and_cache()

    icon = WEATHER_CODE_ICONS.get(cached["weather_code"], "question_mark")
    return {"temperature": cached["temperature"], "icon": icon}


if __name__ == "__main__":
    print(json.dumps(get_weather()))
