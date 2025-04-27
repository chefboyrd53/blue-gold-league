from sqlalchemy import Column, Integer, String, Float
from db import Base

class Player(Base):
    __tablename__ = "players"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    position = Column(String)
    team = Column(String)
    points = Column(Float, default=0.0)
