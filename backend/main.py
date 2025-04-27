from fastapi import FastAPI
from db import Base, engine
from routers import players, teams, matchups, lineup

app = FastAPI()

# Create the tables in the database
Base.metadata.create_all(bind=engine)

# Include routers
app.include_router(players.router, prefix="/players", tags=["Players"])
app.include_router(teams.router, prefix="/teams", tags=["Teams"])
app.include_router(matchups.router, prefix="/matchups", tags=["Matchups"])
app.include_router(lineup.router, prefix="/lineup", tags=["Lineup"])

@app.get("/")
def root():
    return {"message": "Blue Gold League Backend Running"}
