from fastapi import FastAPI
from sqlalchemy import select
from database import SessionLocal
from models import User

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Life Logistics backend is running"}

@app.get("/users")
def read_users():
    with SessionLocal() as session:
        result = session.execute(select(User))
        users = result.scalars().all()
    return {"users": [{"id": user.id, "auth_id": user.auth_id, "name": user.name, "username": user.username, "birthday": user.birthday, "email": user.email, "acc_created_date": user.acc_created_date, "color": user.color} for user in users]}
    