from fastapi import FastAPI, WebSocket
import json
from models import PathfindingRequest, PathfindingResponse
from pathfinding_algorithm import compute_path

app = FastAPI()

@app.websocket("/pathfind")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    while True:
        data = await websocket.receive_text()
        request = PathfindingRequest.parse_raw(data)
        path = compute_path(request.start, request.destination, request.building_id)
        response = PathfindingResponse(path=path)
        await websocket.send_text(response.json())

