import sys
import json
import numpy as np
import soundfile as sf

def analyze_gender(audio_path):
    try:
        data, sr = sf.read(audio_path)
        duration = len(data) / sr
        if len(data.shape) > 1:
            data = np.mean(data, axis=1)
        if len(data) < sr * 0.5:
            return {"detectedGender": "unknown", "confidence": 0, "f0": 0, "duration": round(duration, 2), "error": "Audio too short"}
        fft_vals = np.fft.rfft(data * np.hanning(len(data)))
        freqs = np.fft.rfftfreq(len(data), 1 / sr)
        magnitudes = np.abs(fft_vals)
        min_freq, max_freq = 70, 400
        mask = (freqs >= min_freq) & (freqs <= max_freq)
        if not np.any(mask):
            return {"detectedGender": "unknown", "confidence": 0, "f0": 0, "duration": round(duration, 2), "error": "No frequency content in voice range"}
        peak_idx = np.argmax(magnitudes * mask)
        f0 = freqs[peak_idx]
        confidence = min(95, 50 + (magnitudes[peak_idx] / np.max(magnitudes)) * 45)
        if 160 <= f0 <= 280:
            detected_gender = "female"
        elif 85 <= f0 <= 180:
            detected_gender = "male"
        else:
            detected_gender = "unknown"
        return {"detectedGender": detected_gender, "confidence": round(confidence), "f0": round(f0, 1), "duration": round(duration, 2)}
    except Exception as e:
        return {"detectedGender": "unknown", "confidence": 0, "f0": 0, "duration": 0, "error": str(e)}

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(json.dumps({"detectedGender": "unknown", "confidence": 0, "f0": 0, "duration": 0, "error": "No file provided"}))
        sys.exit(1)
    result = analyze_gender(sys.argv[1])
    print(json.dumps(result))
