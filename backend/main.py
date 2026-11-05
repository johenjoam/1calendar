from fastapi import FastAPI
from sqlalchemy import select
from database import SessionLocal
from models import User
from schemas import UserCreate
import datetime
from sqlalchemy.exc import IntegrityError
from fastapi import HTTPException

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

@app.post("/users", status_code=201)
def create_user(user: UserCreate):
    with SessionLocal() as session:
        new_user = User(
            **user.model_dump(),
            acc_created_date=datetime.date.today().isoformat(),
        )
        try:
            session.add(new_user)
            session.commit()
        except IntegrityError:
            session.rollback()
            raise HTTPException(status_code=409, detail="Username or email already exists")
        session.refresh(new_user)
        return {"id": new_user.id, "auth_id": new_user.auth_id, "name": new_user.name, "username": new_user.username, "birthday": new_user.birthday, "email": new_user.email, "acc_created_date": new_user.acc_created_date, "color": new_user.color}

try:
    create_user(UserCreate(name="Test", email="test@example.com", username="testuser"))
except IntegrityError:
    raise HTTPException(status_code=400, detail="User already exists")