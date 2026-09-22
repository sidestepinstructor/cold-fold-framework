import redis
import os

# Connect to Redis (optional for now)
r = redis.Redis(
    host=os.getenv("REDIS_HOST", "redis"),
    port=6379,
    decode_responses=True
)

def cycle(payload):
    """Cold-Fold core operator."""
    r.lpush("coldfold:cycles", str(payload))
    return {"status": "ok", "payload": payload}

if __name__ == "__main__":
    print("Cold-Fold Engine Online")
