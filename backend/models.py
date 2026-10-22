from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class User(Base):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(primary_key=True)
    auth_id: Mapped[str | None] = mapped_column(unique=True)
    name: Mapped[str | None] = mapped_column()
    username: Mapped[str | None] = mapped_column(unique=True)
    birthday: Mapped[str | None]
    email: Mapped[str | None] = mapped_column(unique=True)
    acc_created_date: Mapped[str | None]
    color: Mapped[str | None]
    