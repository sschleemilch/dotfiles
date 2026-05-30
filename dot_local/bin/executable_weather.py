#!/usr/bin/env python3
import json
import urllib.request
from datetime import date, datetime
from pathlib import Path

CACHE = Path.home() / ".cache/basti/weather.json"

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
    "&hourly=temperature_2m,weather_code"
    "&timezone=Europe%2FBerlin"
    "&forecast_days=1"
)


def load_cache() -> dict | None:
    if not CACHE.exists():
        return None
    cached = json.loads(CACHE.read_text())
    if cached.get("date") != date.today().isoformat():
        return None
    return cached


def save_cache(data: dict) -> None:
    CACHE.parent.mkdir(parents=True, exist_ok=True)
    CACHE.write_text(json.dumps(data))


def fetch_and_cache() -> dict:
    with urllib.request.urlopen(URL, timeout=10) as resp:
        data = json.loads(resp.read())

    payload = {
        "date": date.today().isoformat(),
        "times": data["hourly"]["time"],
        "temperatures": data["hourly"]["temperature_2m"],
        "weather_codes": data["hourly"]["weather_code"],
    }
    save_cache(payload)
    return payload


def current_hour_index(times: list[str]) -> int:
    now = datetime.now()
    current_prefix = now.strftime("%Y-%m-%dT%H:")
    for i, t in enumerate(times):
        if t.startswith(current_prefix):
            return i
    return min(
        range(len(times)),
        key=lambda i: abs(datetime.fromisoformat(times[i]).hour - now.hour),
    )


def get_weather() -> dict:
    cached = load_cache()
    if cached is None:
        cached = fetch_and_cache()

    idx = current_hour_index(cached["times"])
    temperature = cached["temperatures"][idx]
    code = cached["weather_codes"][idx]
    icon = WEATHER_CODE_ICONS.get(code, "question_mark")

    return {"temperature": temperature, "icon": icon}


if __name__ == "__main__":
    print(json.dumps(get_weather()))
