from pydantic import BaseModel

class HouseholdCreate(BaseModel):
    name: str


class UserCreate(BaseModel):
    name: str
    email: str
    username: str
    birthday: str | None = None
    color: str | None = None


    