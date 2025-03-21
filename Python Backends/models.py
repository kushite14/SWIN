# models.py
from datetime import datetime
from pydantic import BaseModel

class EmergencyAlert(BaseModel):
    alert_time: datetime
    level: int
    zones: list[str]
