from sqlalchemy import BigInteger, ForeignKey, String
from sqlalchemy.orm import (
    DeclarativeBase,
    Mapped,
    mapped_column,
    relationship,
)


class Base(DeclarativeBase):
    pass


class User(Base):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(
        BigInteger,
        primary_key=True,
    )
    name: Mapped[str] = mapped_column(String(100))

    orders: Mapped[list["Order"]] = relationship(
        back_populates="user",
    )


class Order(Base):
    __tablename__ = "orders"

    id: Mapped[int] = mapped_column(
        BigInteger,
        primary_key=True,
    )
    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id"),
    )

    user: Mapped[User] = relationship(
        back_populates="orders",
    )
