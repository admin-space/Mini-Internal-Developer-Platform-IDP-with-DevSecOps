import time
from fastapi import FastAPI, Depends, HTTPException, Request
from fastapi.responses import Response
from sqlalchemy.orm import Session
from sqlalchemy import Column, Integer, String
from prometheus_client import generate_latest, CONTENT_TYPE_LATEST, Counter, Histogram

from .core.config import settings
from .core.database import Base, engine, get_db

app = FastAPI(title=settings.APP_NAME)

# Database Model
class Item(Base):
    __tablename__ = "items"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    description = Column(String, index=True)

# Initialize database tables
Base.metadata.create_all(bind=engine)

# Prometheus metrics setup
REQUEST_COUNT = Counter("app_requests_total", "Total App Requests", ["method", "endpoint", "http_status"])
REQUEST_LATENCY = Histogram("app_request_latency_seconds", "Request Latency", ["method", "endpoint"])

@app.middleware("http")
async def monitor_requests(request: Request, call_next):
    start_time = time.time()
    response = await call_next(request)
    latency = time.time() - start_time
    
    if request.url.path != "/metrics":
        REQUEST_COUNT.labels(
            method=request.method,
            endpoint=request.url.path,
            http_status=response.status_code
        ).inc()
        REQUEST_LATENCY.labels(
            method=request.method,
            endpoint=request.url.path
        ).observe(latency)
        
    return response

@app.get("/health")
def health(db: Session = Depends(get_db)):
    try:
        # Perform a simple check query
        db.execute(Base.metadata.tables["items"].select().limit(1))
        return {"status": "healthy", "database": "connected"}
    except Exception as e:
        raise HTTPException(status_code=503, detail=f"Database connection failed: {str(e)}")

@app.get("/metrics")
def metrics():
    return Response(content=generate_latest(), media_type=CONTENT_TYPE_LATEST)

@app.get("/items")
def read_items(db: Session = Depends(get_db)):
    items = db.query(Item).all()
    return items

@app.post("/items", status_code=201)
def create_item(name: str, description: str, db: Session = Depends(get_db)):
    db_item = Item(name=name, description=description)
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return {"id": db_item.id, "name": db_item.name, "description": db_item.description}
